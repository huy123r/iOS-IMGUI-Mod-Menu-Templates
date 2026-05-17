#import <UIKit/UIKit.h>
#import <substrate.h>

// -----------------------------------------------------------------------------
// KHAI BÁO CÁC HÀM CỦA THƯ VIỆN ĐỒ HỌA IMGUI
// -----------------------------------------------------------------------------
namespace ImGui {
    struct ImVec2 { float x, y; ImVec2() { x = y = 0.0f; } ImVec2(float _x, float _y) { x = _x; y = _y; } };
    struct ImVec4 { float x, y, z, w; ImVec4() { x = y = z = w = 0.0f; } ImVec4(float _x, float _y, float _z, float _w) { x = _x; y = _y; z = _z; w = _w; } };
    struct ImGuiStyle { ImVec2 WindowPadding; ImVec2 FramePadding; ImVec2 ItemSpacing; float WindowRounding; float FrameRounding; ImVec2 ButtonTextAlign; ImVec4 Colors[55]; };
    
    ImGuiStyle& GetStyle();
    bool Begin(const char* name, bool* p_open = NULL, int flags = 0);
    void End();
    void Text(const char* fmt, ...);
    void TextColored(const ImVec4& col, const char* fmt, ...);
    bool Checkbox(const char* label, bool* v);
    void Separator();
    void Spacing();
    void SetNextWindowSize(const ImVec2& size, int cond = 0);
}

// Định nghĩa các cờ cấu hình thuộc tính hiển thị
#define ImGuiWindowFlags_NoCollapse (1 << 5)
#define ImGuiCond_FirstUseEver (1 << 0)
#define ImGuiCol_WindowBg 2
#define ImGuiCol_Text 0
#define ImGuiCol_TextDisabled 1
#define ImGuiCol_TitleBg 11
#define ImGuiCol_TitleBgActive 12
#define ImGuiCol_FrameBg 4
#define ImGuiCol_FrameBgHovered 5
#define ImGuiCol_FrameBgActive 6
#define ImGuiCol_CheckMark 18
#define ImGuiCol_SliderGrab 19
#define ImGuiCol_SliderGrabActive 20
#define ImGuiCol_Button 21
#define ImGuiCol_ButtonHovered 22
#define ImGuiCol_ButtonActive 23

// -----------------------------------------------------------------------------
// KHU VỰC 1: CÁC CÔNG TẮC TRẠNG THÁI (GLOBAL STATES)
// -----------------------------------------------------------------------------
static bool bInfiniteSun = false;
static bool bNoCooldown = false;

// -----------------------------------------------------------------------------
// KHU VỰC 2: CẤU HÌNH PHỐI MÀU VÀ BO GÓC MENU ĐẸP (THEME)
// -----------------------------------------------------------------------------
void ApplyNeonDarkTheme() {
    ImGui::ImGuiStyle& style = ImGui::GetStyle();
    
    // Thiết lập độ bo góc hiện đại và khoảng cách các nút bấm dễ chạm
    style.WindowPadding          = ImGui::ImVec2(15.0f, 15.0f);
    style.FramePadding           = ImGui::ImVec2(12.0f, 6.0f);
    style.ItemSpacing            = ImGui::ImVec2(10.0f, 10.0f);
    style.WindowRounding         = 12.0f; // Bo tròn khung menu
    style.FrameRounding          = 6.0f;  // Bo tròn ô checkbox
    style.ButtonTextAlign        = ImGui::ImVec2(0.5f, 0.5f);

    // Bảng phối màu phong cách tối kết hợp xanh Neon sáng
    ImGui::ImVec4* colors = style.Colors;
    colors[ImGuiCol_WindowBg]             = ImGui::ImVec4(0.10f, 0.10f, 0.12f, 0.95f); // Nền xám đen mờ
    colors[ImGuiCol_TitleBg]              = ImGui::ImVec4(0.16f, 0.16f, 0.20f, 1.00f);
    colors[ImGuiCol_TitleBgActive]        = ImGui::ImVec4(0.20f, 0.20f, 0.25f, 1.00f);
    colors[ImGuiCol_Text]                 = ImGui::ImVec4(0.95f, 0.95f, 0.95f, 1.00f); // Chữ trắng sáng
    colors[ImGuiCol_TextDisabled]         = ImGui::ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
    colors[ImGuiCol_FrameBg]              = ImGui::ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_FrameBgHovered]       = ImGui::ImVec4(0.28f, 0.28f, 0.32f, 1.00f);
    colors[ImGuiCol_FrameBgActive]        = ImGui::ImVec4(0.35f, 0.35f, 0.40f, 1.00f);
    colors[ImGuiCol_CheckMark]            = ImGui::ImVec4(0.00f, 0.90f, 0.45f, 1.00f); // Tích chọn xanh neon
    colors[ImGuiCol_SliderGrab]           = ImGui::ImVec4(0.00f, 0.90f, 0.45f, 1.00f);
    colors[ImGuiCol_SliderGrabActive]     = ImGui::ImVec4(0.00f, 1.00f, 0.50f, 1.00f);
    colors[ImGuiCol_Button]               = ImGui::ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_ButtonHovered]        = ImGui::ImVec4(0.00f, 0.75f, 0.38f, 1.00f);
    colors[ImGuiCol_ButtonActive]         = ImGui::ImVec4(0.00f, 0.60f, 0.30f, 1.00f);
}

// -----------------------------------------------------------------------------
// KHU VỰC 3: HÀM DỰNG CỬA SỔ MENU VÀ CÁC NÚT TÍCH CHỌN
// -----------------------------------------------------------------------------
void RenderPvZModMenu() {
    // Kích hoạt bảng màu làm đẹp
    ApplyNeonDarkTheme();

    // Thiết lập kích thước mặc định cho menu (Rộng 420px, Cao 320px)
    ImGui::SetNextWindowSize(ImGui::ImVec2(420, 320), ImGuiCond_FirstUseEver);

    // Vẽ cửa sổ đồ họa
    if (ImGui::Begin(" PVZ FUSION MOD MENU ", NULL, ImGuiWindowFlags_NoCollapse)) {
        
        ImGui::TextColored(ImGui::ImVec4(0.00f, 0.90f, 0.45f, 1.00f), "DEVELOPER TOOLS v1.0");
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
        
        ImGui::TextDisabled("Hệ thống vận hành an toàn qua Sideloadly.");
        
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
    // Giữ nguyên các tập lệnh vẽ nền gốc của template để không gây lỗi màn hình
    [super drawRect:rect];

    // GỌI HÀM HIỂN THỊ MENU: Bản menu của bạn sẽ liên tục được cập nhật lên trên màn hình game
    RenderPvZModMenu();
}

@end

// -----------------------------------------------------------------------------
// KHU VỰC 5: LIÊN KẾT HOOK (CAN THIỆP THAY ĐỔI LOGIC GAME)
// -----------------------------------------------------------------------------

// Hàm thay thế lượng Mặt Trời gốc
int (*old_GetSun)(void* instance);
int new_GetSun(void* instance) {
    if (bInfiniteSun) {
        return 9999; // Bật menu thì luôn trả về 9999 mặt trời
    }
    return old_GetSun(instance); // Tắt menu thì trả về giá trị gốc của màn chơi
}

// Hàm thay thế bộ đếm thời gian hồi chiêu gốc
bool (*old_IsReady)(void* instance) {
    if (bNoCooldown) {
        return true; // Bật menu thì luôn báo thẻ bài cây trồng sẵn sàng
    }
    return old_IsReady(instance); // Tắt menu thì phải đợi đếm giây bình thường
}

// Hàm khởi tạo tự động chạy khi file dylib được game nạp lên RAM
__attribute__((constructor)) static void initialize() {
    // Thực hiện liên kết địa chỉ bộ nhớ (Offset) của game tại đây khi phân tích cấu trúc nhị phân.
    // Ví dụ lệnh đăng ký của Substrate:
    // MSHookFunction((void*)(0x10000000), (void*)new_GetSun, (void**)&old_GetSun);
}
