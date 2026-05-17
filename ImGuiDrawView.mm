// Thêm hàm này vào trong tệp ImGuiDrawView.mm của bạn
void SetBeautifulStyle() {
    ImGuiStyle& style = ImGui::GetStyle();
    
    // ==========================================
    // CẤU HÌNH ĐỘ BO GÓC VÀ KÍCH THƯỚC (Dễ bấm trên màn hình cảm ứng)
    // ==========================================
    style.WindowPadding          = ImVec2(15.0f, 15.0f); // Khoảng cách từ viền vào trong
    style.FramePadding           = ImVec2(12.0f, 6.0f);  // Kích thước các ô bấm, hộp chọn
    style.ItemSpacing            = ImVec2(10.0f, 10.0f); // Khoảng cách giữa các dòng
    style.WindowRounding         = 12.0f;                // Bo tròn góc sổ menu (Nhìn hiện đại)
    style.FrameRounding          = 6.0f;                 // Bo tròn góc các ô nhập/Checkbox
    style.ButtonTextAlign        = ImVec2(0.5f, 0.5f);   // Căn chữ ở giữa nút bấm

    // ==========================================
    // CẤU HÌNH MÀU SẮC (Phong cách Dark & Neon Green)
    // ==========================================
    ImVec4* colors = style.Colors;
    
    // Màu nền chính của Menu (Màu xám tối / đen mờ)
    colors[ImGuiCol_WindowBg]             = ImVec4(0.10f, 0.10f, 0.12f, 0.95f); 
    
    // Màu thanh tiêu đề ở trên cùng
    colors[ImGuiCol_TitleBg]              = ImVec4(0.16f, 0.16f, 0.20f, 1.00f);
    colors[ImGuiCol_TitleBgActive]        = ImVec4(0.20f, 0.20f, 0.25f, 1.00f);
    
    // Màu chữ hiển thị
    colors[ImGuiCol_Text]                 = ImVec4(0.95f, 0.95f, 0.95f, 1.00f);
    colors[ImGuiCol_TextDisabled]         = ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
    
    // Màu của các khung chứa (Nền của Checkbox, Slider)
    colors[ImGuiCol_FrameBg]              = ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_FrameBgHovered]       = ImVec4(0.28f, 0.28f, 0.32f, 1.00f);
    colors[ImGuiCol_FrameBgActive]        = ImVec4(0.35f, 0.35f, 0.40f, 1.00f);
    
    // Màu sắc điểm nhấn khi BẬT tính năng (Màu Xanh Neon sáng)
    colors[ImGuiCol_CheckMark]            = ImVec4(0.00f, 0.90f, 0.45f, 1.00f); // Dấu tích xanh
    colors[ImGuiCol_SliderGrab]           = ImVec4(0.00f, 0.90f, 0.45f, 1.00f);
    colors[ImGuiCol_SliderGrabActive]     = ImVec4(0.00f, 1.00f, 0.50f, 1.00f);
    
    // Màu sắc của nút bấm (Buttons)
    colors[ImGuiCol_Button]               = ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_ButtonHovered]        = ImVec4(0.00f, 0.75f, 0.38f, 1.00f); // Di chuột/chạm vào đổi sang xanh
    colors[ImGuiCol_ButtonActive]         = ImVec4(0.00f, 0.60f, 0.30f, 1.00f);
}
