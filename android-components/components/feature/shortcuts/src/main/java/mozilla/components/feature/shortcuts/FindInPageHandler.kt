package mozilla.components.feature.shortcuts

import android.view.KeyEvent
import mozilla.components.support.utils.DispatchKeyHandler

class FindInPageHandler(_launchFind: () -> Unit) : DispatchKeyHandler() {
    val launchFind = _launchFind

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.isCtrlPressed && event.getKeyCode() == KeyEvent.KEYCODE_F) {
            launchFind()
            return true
        }
        return false
    }
}
