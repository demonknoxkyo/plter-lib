package com.plter.usingvca;

import android.os.Bundle;
import android.view.View;

import com.plter.lib.android.java.controls.ViewControllerActivity;

public class E005_UsingViewControllerActivityActivity extends ViewControllerActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        findViewById(R.id.nextBtn).setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				pushViewController(new Mn1Vc(E005_UsingViewControllerActivityActivity.this), true);
			}
		});
    }
}