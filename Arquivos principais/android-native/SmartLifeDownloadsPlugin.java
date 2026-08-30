package com.smartlife.app;

import android.Manifest;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Base64;

import com.getcapacitor.JSObject;
import com.getcapacitor.PermissionState;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.Permission;
import com.getcapacitor.annotation.PermissionCallback;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

@CapacitorPlugin(
    name = "SmartLifeDownloads",
    permissions = {
        @Permission(alias = "storage", strings = {Manifest.permission.WRITE_EXTERNAL_STORAGE})
    }
)
public class SmartLifeDownloadsPlugin extends Plugin {
    @PluginMethod
    public void saveFile(PluginCall call) {
        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.P
                && getPermissionState("storage") != PermissionState.GRANTED) {
            requestPermissionForAlias("storage", call, "storagePermissionCallback");
            return;
        }
        saveToDownloads(call);
    }

    @PermissionCallback
    private void storagePermissionCallback(PluginCall call) {
        if (getPermissionState("storage") == PermissionState.GRANTED) {
            saveToDownloads(call);
        } else {
            call.reject("Permissão para salvar na pasta Downloads negada.");
        }
    }

    private void saveToDownloads(PluginCall call) {
        String requestedName = call.getString("filename");
        String encoded = call.getString("base64");
        String mimeType = call.getString("mimeType", "application/json");

        if (requestedName == null || requestedName.trim().isEmpty()) {
            call.reject("Nome do arquivo não informado.");
            return;
        }
        if (encoded == null || encoded.isEmpty()) {
            call.reject("Conteúdo do arquivo não informado.");
            return;
        }

        String safeName = new File(requestedName).getName();
        if (safeName.isEmpty() || ".".equals(safeName) || "..".equals(safeName)) {
            call.reject("Nome de arquivo inválido.");
            return;
        }

        Uri createdUri = null;
        try {
            byte[] bytes = Base64.decode(encoded, Base64.DEFAULT);
            String storedName = safeName;

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                ContentResolver resolver = getContext().getContentResolver();
                ContentValues values = new ContentValues();
                values.put(MediaStore.MediaColumns.DISPLAY_NAME, safeName);
                values.put(MediaStore.MediaColumns.MIME_TYPE, mimeType);
                values.put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);
                values.put(MediaStore.MediaColumns.IS_PENDING, 1);

                createdUri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);
                if (createdUri == null) {
                    throw new IllegalStateException("O Android não criou o arquivo em Downloads.");
                }

                try (OutputStream output = resolver.openOutputStream(createdUri)) {
                    if (output == null) {
                        throw new IllegalStateException("Não foi possível abrir o arquivo em Downloads.");
                    }
                    output.write(bytes);
                    output.flush();
                }

                values.clear();
                values.put(MediaStore.MediaColumns.IS_PENDING, 0);
                resolver.update(createdUri, values, null, null);
            } else {
                File downloads = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
                if (!downloads.exists() && !downloads.mkdirs()) {
                    throw new IllegalStateException("Não foi possível acessar a pasta Downloads.");
                }
                File destination = uniqueFile(downloads, safeName);
                storedName = destination.getName();
                try (FileOutputStream output = new FileOutputStream(destination)) {
                    output.write(bytes);
                    output.flush();
                }
                createdUri = Uri.fromFile(destination);
                MediaScannerConnection.scanFile(
                    getContext(),
                    new String[]{destination.getAbsolutePath()},
                    new String[]{mimeType},
                    null
                );
            }

            JSObject result = new JSObject();
            result.put("filename", storedName);
            result.put("path", "Downloads/" + storedName);
            result.put("uri", createdUri == null ? "" : createdUri.toString());
            call.resolve(result);
        } catch (Exception error) {
            if (createdUri != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                try {
                    getContext().getContentResolver().delete(createdUri, null, null);
                } catch (Exception ignored) {
                    // O erro original é o mais importante para o usuário.
                }
            }
            String message = error.getMessage();
            call.reject(message == null || message.isEmpty()
                ? "Não foi possível salvar o arquivo em Downloads."
                : message, error);
        }
    }

    private File uniqueFile(File directory, String filename) {
        File original = new File(directory, filename);
        if (!original.exists()) return original;

        int dot = filename.lastIndexOf('.');
        String base = dot > 0 ? filename.substring(0, dot) : filename;
        String extension = dot > 0 ? filename.substring(dot) : "";
        int copy = 1;
        File candidate;
        do {
            candidate = new File(directory, base + " (" + copy + ")" + extension);
            copy++;
        } while (candidate.exists());
        return candidate;
    }
}
