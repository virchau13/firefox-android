package mozilla.components.feature.shortcuts

import android.view.KeyEvent
import mozilla.components.support.utils.DispatchKeyHandler

class NewTabHandler(_openNewTab: () -> Unit) : DispatchKeyHandler() {
    val openNewTab = _openNewTab

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.isCtrlPressed && event.getKeyCode() == KeyEvent.KEYCODE_T) {
            openNewTab()
            return true
        }
        return false
    }
}
