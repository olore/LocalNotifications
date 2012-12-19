1. Install via pluginstall
2. Add a line to AlarmReceiver.java to import your R class (ex. import com.myapp.R;)


Nice tutorial for pluginstall : http://blog.chariotsolutions.com/2012/11/installing-phonegap-plugins-with.html


3. Add the following fragment in the AndroidManifest.xml inside the &lt;application&gt; tag:

        <receiver android:name="com.phonegap.plugin.localnotification.AlarmReceiver" >
        </receiver>
		
        <receiver android:name="com.phonegap.plugin.localnotification.AlarmRestoreOnBoot" >
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED" />
            </intent-filter>
        </receiver>
    
    The first part tells Android to launch the AlarmReceiver class when the alarm is be triggered. This will also work when the application is not running.
	The second part restores all added alarms upon device reboot (because Android 'forgets' all alarms after a restart).
	
7. The following piece of code is a minimal example in which you can test the notification:

        	<script type="text/javascript">
                        document.addEventListener("deviceready", appReady, false);
			
                        function appReady() {
                        	console.log("Device ready");
				
                        	if (typeof plugins !== "undefined") {
                        		plugins.localNotification.add({
                        			date : new Date(),
                        			message : "Phonegap - Local Notification\r\nSubtitle comes after linebreak",
                        			ticker : "This is a sample ticker text",
                        			repeatDaily : false,
                        			id : 4
                			});
                		}
        		}
			
                	document.addEventListener("deviceready", appReady, false);
                </script>
		
4. You can use the following commands:

	- plugins.localNotification.add({ date: new Date(), message: 'This is an Android alarm using the statusbar', id: 123 });
	- plugins.localNotification.cancel(123); 
	- plugins.localNotification.cancelAll();
		