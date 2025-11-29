package pure.apk;

import android.os.Bundle;
import android.view.View;
import android.view.Gravity;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Button;

public class MainActivity extends android.app.Activity {

    private int counter = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(createView());
    }

    private View createView() {
        final TextView tv = new TextView(this);
        tv.setGravity(Gravity.CENTER);
        tv.setText("Waiting for input");

        final Button btn = new Button(this);
        btn.setText("Increment");
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                tv.setText("You've counted up to " + ++MainActivity.this.counter + "!");
            }
        });

        final LinearLayout ll = new LinearLayout(this);
        ll.setGravity(Gravity.CENTER);
        ll.setOrientation(LinearLayout.VERTICAL);
        ll.addView(tv);
        ll.addView(btn);
        return ll;
    }
}

