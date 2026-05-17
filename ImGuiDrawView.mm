#import <UIKit/UIKit.h>
#import <substrate.h>

// Gọi trực tiếp tệp cấu trúc gốc của thư viện ImGui đi kèm dự án thay vì khai báo thủ công
#include "imgui.h"

// -----------------------------------------------------------------------------
// KHU VỰC 1: CÁC CÔNG TẮC TRẠNG THÁI (GLOBAL STATES)
// -----------------------------------------------------------------------------
static bool bInfiniteSun = false;
static bool bNoCooldown = false;

// -----------------------------------------------------------------------------
// KHU VỰC 2: CẤU HÌNH PHỐI MÀU VÀ BO GÓC MENU ĐẸP (THEME)
// -----------------------------------------------------------------------------
void ApplyNeonDarkTheme() {
    ImGuiStyle& style = ImGui::GetStyle();
    
    // Thiết lập độ bo góc hiện đại và khoảng cách các nút bấm dễ chạm
    style.WindowPadding          = ImVec2(15.0f, 15.0f);
    style.FramePadding           = ImVec2(12.0f, 6.0f);
    style.ItemSpacing            = ImVec2(10.0f, 10.0f);
    style.WindowRounding         = 12.0f; // Bo tròn khung menu
    style.FrameRounding          = 6.0f;  // Bo tròn ô checkbox
    style.ButtonTextAlign        = ImVec2(0.5f, 0.5f);

    // Bảng phối màu phong cách tối kết hợp xanh Neon sáng
    ImVec4* colors = style.Colors;
    colors[ImGuiCol_WindowBg]             = ImVec4(0.10f, 0.10f, 0.12f, 0.95f); // Nền xám đen mờ
    colors[ImGuiCol_TitleBg]              = ImVec4(0.16f, 0.16f, 0.20f, 1.00f);
    colors[ImGuiCol_TitleBgActive]        = ImVec4(0.20f, 0.20f, 0.25f, 1.00f);
    colors[ImGuiCol_Text]                 = ImVec4(0.95f, 0.95f, 0.95f, 1.00f); // Chữ trắng sáng
    colors[ImGuiCol_TextDisabled]         = ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
    colors[ImGuiCol_FrameBg]              = ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_FrameBgHovered]       = ImVec4(0.28f, 0.28f, 0.32f, 1.00f);
    colors[ImGuiCol_FrameBgActive]        = ImVec4(0.35f, 0.35f, 0.40f, 1.00f);
    colors[ImGuiCol_CheckMark]            = ImVec4(0.00f, 0.90f, 0.45f, 1.00f); // Tích chọn xanh neon
    colors[ImGuiCol_SliderGrab]           = ImVec4(0.00f, 0.90f, 0.45f, 1.00f);
    colors[ImGuiCol_SliderGrabActive]     = ImVec4(0.00f, 1.00f, 0.50f, 1.00f);
    colors[ImGuiCol_Button]               = ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_ButtonHovered]        = ImVec4(0.00f, 0.75f, 0.38f, 1.00f);
    colors[ImGuiCol_ButtonActive]         = ImVec4(0.00f, 0.60f, 0.30f, 1.00f);
}

// -----------------------------------------------------------------------------
// KHU VỰC 3: HÀM DỰNG CỬA SỔ MENU VÀ CÁC NÚT TÍCH CHỌN
// -----------------------------------------------------------------------------
void RenderPvZModMenu() {
    // Kích hoạt bảng màu làm đẹp
    ApplyNeonDarkTheme();

    // Thiết lập kích thước mặc định cho menu (Rộng 420px, Cao 320px)
    ImGui::SetNextWindowSize(ImVec2(420, 320), ImGuiCond_FirstUseEver);

    // Vẽ cửa sổ đồ họa
    if (ImGui::Begin(" PVZ FUSION MOD MENU ", NULL, ImGuiWindowFlags_NoCollapse)) {
        
        ImGui::TextColored(ImVec4(0.00f, 0.90f, 0.45f, 1.00f), "DEVELOPER TOOLS v1.0");
        ImGui::Separator(); 
        ImGui::Spacing();

        // Danh mục quản lý Mặt Trời
        ImGui::Text(" Quản lý Tài Nguyên:");
        ImGui::Spacing();
        ImGui::Checkbox("Vô Hạn Mặt Trời (Infinite Sun)", &bInfiniteSun);
        
        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();

        // Danh mục quản lý thời gian chờ trồng cây
        ImGui::Text(" Quản lý Cơ Chế Chơi:");
        ImGui::Spacing();
        ImGui::Checkbox("Hồi Chiêu Siêu Tốc (No Cooldown)", &bNoCooldown);

        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();
        
        ImGui::Text("Hệ thống vận hành an toàn qua Sideloadly.");
        
        ImGui::End();
    }
}

// -----------------------------------------------------------------------------
// KHU VỰC 4: NHÚNG VÀO LỚP HIỂN THỊ ĐỒ HỌA (RENDER VIEW) CỦA IOS
// -----------------------------------------------------------------------------
@interface ImGuiDrawView : UIView
- (void)drawRect:(CGRect)rect;
@end

@implementation ImGuiDrawView

// Vòng lặp vẽ đồ họa chạy liên tục của thiết bị iOS
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    // Gọi menu hiển thị cập nhật theo từng khung hình
    RenderPvZModMenu();
}

@end

// -----------------------------------------------------------------------------
// KHU VỰC 5: LIÊN KẾT HOOK (CAN THIỆP THAY ĐỔI LOGIC GAME)
// -----------------------------------------------------------------------------

int (*old_GetSun)(void* instance);
int new_GetSun(void* instance) {
    if (bInfiniteSun) {
        return 9999; 
    }
    return old_GetSun(instance); 
}

bool (*old_IsReady)(void* instance);
bool new_IsReady(void* instance) {
    if (bNoCooldown) {
        return true; 
    }
    return old_IsReady(instance); 
}

__attribute__((constructor)) static void initialize() {
    // Khi chạy trên thiết bị thực tế, các lệnh Hook sẽ được kích hoạt tại đây
}
