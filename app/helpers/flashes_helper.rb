module FlashesHelper  #flashes所對應的helper
  FLASH_CLASSES={alert: "danger", notice: "success", warning: "warning"}.freeze

  #傳進來的key會用FLASH_CLASSES轉換成令一個值
  def flash_class(key)
    FLASH_CLASSES.fetch key.to_sym, key
  end

  #將flash物件一個個切開，以便view跑迴圈個別處理錯誤訊息
  def user_facing_flashes
    flash.to_hash.slice "alert", "notice", "warning"
  end
end
