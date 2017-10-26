
package com.reactlibrary.sm_alert;

import android.app.Activity;

import com.bigkoo.alertview.AlertView;
import com.bigkoo.alertview.OnDismissListener;
import com.bigkoo.alertview.OnItemClickListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.JSApplicationIllegalArgumentException;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.UiThreadUtil;
import com.facebook.react.bridge.WritableMap;

public class SMOSmAlertModule extends ReactContextBaseJavaModule{

  private final ReactApplicationContext reactContext;
  private Callback mCallBack;
  private int mEndPosition = -1;

  public SMOSmAlertModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "SMOSmAlert";
  }
  
  
  @ReactMethod
  public void alertDefault(ReadableMap params, Callback callback){
    mCallBack = callback;
    final ReadableMap Params = params;

    UiThreadUtil.runOnUiThread(new Runnable() {
      @Override
      public void run() {

        ReadableArray buttons = Arguments.createArray();
        String _title = null;
        String _message = null;
        if (Params.hasKey("title")) {
          _title = Params.getString("title");
        }
        if (Params.hasKey("message")) {
          _message = Params.getString("message");
        }
        if (Params.hasKey("buttons")) {
          buttons = Params.getArray("buttons");
        }

        String[] alertButtons;
        if(buttons.size() == 0){
          alertButtons = new String[]{"确定"};
        }else{
          alertButtons = new String[buttons.size()];
          for(int i = 0; i < buttons.size(); i++){
            alertButtons[i] = buttons.getString(i);
          }
        }

        Activity activity = getCurrentActivity();
        if (activity == null) {
          throw new JSApplicationIllegalArgumentException("Tried to open a Alert view while not attached to an Activity");
        }

        mEndPosition = -1;
        AlertView alertView = new AlertView(_title, _message, null, null,
                alertButtons,
                activity, AlertView.Style.Alert, new OnItemClickListener(){
          public void onItemClick(Object o,int position){
            if(mCallBack != null){
              mEndPosition = position;
            }
          }
        }).setCancelable(false);
        alertView.setOnDismissListener(new OnDismissListener(){
          public void onDismiss(Object o){
            if(mCallBack != null){
              WritableMap response = Arguments.createMap();
              response.putInt("index", mEndPosition);
              mCallBack.invoke(response);
              mCallBack = null;
            }
          }
        });
        alertView.show();
      }
    });
  }


  @ReactMethod
  public void alertBottom(ReadableMap params, Callback callback){
    mCallBack = callback;
    final ReadableMap Params = params;

    UiThreadUtil.runOnUiThread(new Runnable() {
      @Override
      public void run() {

        ReadableArray buttons = Arguments.createArray();
        String _title = null;
        String _message = null;
        if (Params.hasKey("title")) {
          _title = Params.getString("title");
        }
        if (Params.hasKey("message")) {
          _message = Params.getString("message");
        }
        if (Params.hasKey("buttons")) {
          buttons = Params.getArray("buttons");
        }

        String[] alertButtons;
        if(buttons.size() == 0){
          alertButtons =null;
        }else{
          alertButtons = new String[buttons.size()];
          for(int i = 0; i < buttons.size(); i++){
            alertButtons[i] = buttons.getString(i);
          }
        }

        Activity activity = getCurrentActivity();
        if (activity == null) {
          throw new JSApplicationIllegalArgumentException("Tried to open a Alert view while not attached to an Activity");
        }
        mEndPosition = -1;
        AlertView alertView = new AlertView(_title, _message, "取消", null,
                alertButtons,
                activity, AlertView.Style.ActionSheet, new OnItemClickListener(){
          public void onItemClick(Object o,int position){
            if(mCallBack != null){
              mEndPosition = position;
            }
          }
        }).setCancelable(true);
        alertView.setOnDismissListener(new OnDismissListener(){
          public void onDismiss(Object o){
            if(mCallBack != null){
              WritableMap response = Arguments.createMap();
              response.putInt("index", mEndPosition);
              mCallBack.invoke(response);
              mCallBack = null;
            }
          }
        });
        alertView.show();
      }
    });
  }


}