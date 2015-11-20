package com.quarx2k.hdmimonitor;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.SystemProperties;
import android.util.Log;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by quarx2k on 11.07.15.
 */
public class HdmiService extends Service {
    private static Handler mHandler = null;
    private Runnable mRunnable;
    private Notification.Builder builder = null;
    private NotificationManager manager = null;
    private int oldPropValue = -1;

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        HandlerThread mThread = new HandlerThread("Thread");
        mThread.start();
        mHandler = new Handler(mThread.getLooper());
        if (mRunnable == null) {
            mRunnable = new Runnable() {
                @Override
                public void run() {
                    mHandler.post(new Runnable() {
                        @Override
                        public void run() {
                            checkHdmi();
                            mHandler.postDelayed(mRunnable, 2 * 1000);
                        }
                    });
                }
            };
        }
        new Thread(mRunnable).start();
        return START_STICKY;
    }

    private void checkHdmi() {

        BufferedReader buffered_reader=null;
        try
        {
            buffered_reader = new BufferedReader(new FileReader("/sys/devices/virtual/graphics/fb1/connected"));
            String line = "";

            while ((line = buffered_reader.readLine()) != null)
            {
                if (line.trim().equals("1")) {
                    showNotify(true);
                } else {
                    showNotify(false);
                }
            }

            line = "";
            buffered_reader = new BufferedReader(new FileReader("/sys/android_touch/PAD"));
            while ((line = buffered_reader.readLine()) != null)
            {
                if (line.trim().equals("1")) {
                    if (oldPropValue != 2) {
                        SystemProperties.set("sys.config.resolution", "2");
                        oldPropValue = 2;
                    }
                } else {
                    if (oldPropValue != 1) {
                        SystemProperties.set("sys.config.resolution", "1");
                        oldPropValue = 1;
                    }
                }
            }

        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            try
            {
                if (buffered_reader != null)
                    buffered_reader.close();
            }
            catch (IOException ex)
            {
                ex.printStackTrace();
            }
        }
    }
    private void showNotify(Boolean enable) {
        if (builder == null || manager == null) {
                        builder = new Notification.Builder(this)
                                        .setSmallIcon(R.drawable.hdmi)
                                        .setContentTitle(getString(R.string.hdmi_connected))
                                        .setContentText(getString(R.string.hdmi_connected_text))
                                        .setOngoing(true)
                                        .setAutoCancel(false);
                        manager = (NotificationManager) HdmiService.this.getSystemService(Context.NOTIFICATION_SERVICE);
        }
        if (enable) {
            manager.notify(1, builder.build());
        } else {
            manager.cancel(1);
        }
    }
}
