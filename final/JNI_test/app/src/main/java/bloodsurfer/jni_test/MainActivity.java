package bloodsurfer.jni_test;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.graphics.PorterDuff;

import bloodsurfer.jni_test.Classify_ecg;

public class MainActivity extends AppCompatActivity {

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("classify_ecg");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

//        TextView description = (TextView) findViewById(R.id.description);
//        description.setText(("Probability: \r\nPositive value: apnoe\r\nNegative value: no apnoe"));

        final Button indicator = (Button) findViewById(R.id.indicator);

        Button ap_but = (Button) findViewById(R.id.ap_but);
        ap_but.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                EditText iter_edit = (EditText) findViewById(R.id.n_iter);
                int iter = Integer.parseInt(iter_edit.getText().toString());
                double out = -1;
                for (int i = 0; i < iter; i++)
                {
                    out = Classify_ecg.Classify_next_ap();
                }

                if (out > 0) // apnoe
                {
                    indicator.setText("Apnoe");
                    indicator.getBackground().setColorFilter(0xFFFF0000, PorterDuff.Mode.MULTIPLY); // red
                }
                else // no apnoe
                {
                    indicator.setText("No Apnoe");
                    indicator.getBackground().setColorFilter(0xFF00FF00, PorterDuff.Mode.MULTIPLY); // Grey
                }

                TextView txt = (TextView) findViewById(R.id.sample_text);
                txt.setText(String.valueOf(out));
            }
        });

        Button no_but = (Button) findViewById(R.id.no_but);
        no_but.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                EditText iter_edit = (EditText) findViewById(R.id.n_iter);
                int iter = Integer.parseInt(iter_edit.getText().toString());
                double out = -1;
                for (int i = 0; i < iter; i++)
                {
                    out = Classify_ecg.Classify_next_no();
                }

                if (out > 0) // apnoe
                {
                    indicator.setText("Apnoe");
                    indicator.getBackground().setColorFilter(0xFFFF0000, PorterDuff.Mode.MULTIPLY); // red
                }
                else // no apnoe
                {
                    indicator.setText("No Apnoe");
                    indicator.getBackground().setColorFilter(0xFF00FF00, PorterDuff.Mode.MULTIPLY); // Grey
                }

                TextView txt = (TextView) findViewById(R.id.sample_text);
                txt.setText(String.valueOf(out));
            }
        });

        // Example of a call to a native method
        TextView tv = (TextView) findViewById(R.id.sample_text);
//        tv.setText(stringFromJNI());
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


    /**
     * A native method that is implemented by the 'native-lib' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
//    public native double[] getInput();
}
