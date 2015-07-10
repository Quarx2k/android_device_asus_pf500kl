package com.quarx2k.hdmimonitor;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * Created by quarx2k on 11.07.15.
 */
public class Autostart extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Intent service = new Intent(context, HdmiService.class);
        context.startService(service);
    }
}