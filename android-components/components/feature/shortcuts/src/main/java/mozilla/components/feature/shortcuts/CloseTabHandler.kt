package mozilla.components.feature.shortcuts

import android.view.KeyEvent
import mozilla.components.feature.tabs.TabsUseCases
import mozilla.components.support.utils.DispatchKeyHandler

class CloseTabHandler(_getCurrentTabId: () -> String?, _tabsUseCases: TabsUseCases) : DispatchKeyHandler() {
    val tabsUseCases = _tabsUseCases
    val getCurrentTabId = _getCurrentTabId

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.isCtrlPressed && event.getKeyCode() == KeyEvent.KEYCODE_W) {
            val currTab = getCurrentTabId()
            val retTrue = currTab?.let {
                tabsUseCases.removeTab(it)
                true
            }
            if (retTrue == true) {
                return true
            }
        }
        return false
    }
}
