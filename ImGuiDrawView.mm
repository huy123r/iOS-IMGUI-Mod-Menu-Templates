#import <UIKit/UIKit.h>
#import <MTRootViewController.h> // Thư viện điều khiển cửa sổ gốc của menu
#import <substrate.h>

// Khai báo các hàm thư viện ImGui sử dụng trong dự án
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

// Định nghĩa các hằng số cấu hình ImGui
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

// ==========================================
// THÀNH PHẦN 1: CÁC BIẾN TRẠNG THÁI (CÔNG TẮC)
// ==========================================
static bool bInfiniteSun = false;
static bool bNoCooldown = false;

// ==========================================
// THÀNH PHẦN 2: CẤU HÌNH LÀM ĐẸP GIAO DIỆN (THEME)
// ==========================================
void SetBeautifulStyle() {
    ImGui::ImGuiStyle& style = ImGui::GetStyle();
    
    // Cấu hình bo góc và khoảng cách
    style.WindowPadding          = ImGui::ImVec2(15.0f, 15.0f);
    style.FramePadding           = ImGui::ImVec2(12.0f, 6.0f);
    style.ItemSpacing            = ImGui::ImVec2(10.0f, 10.0f);
    style.WindowRounding         = 12.0f;
    style.FrameRounding          = 6.0f;
    style.ButtonTextAlign        = ImGui::ImVec2(0.5f, 0.5f);

    // Phối màu Dark Mode & Neon Green
    ImGui::ImVec4* colors = style.Colors;
    colors[ImGuiCol_WindowBg]             = ImGui::ImVec4(0.10f, 0.10f, 0.12f, 0.95f); 
    colors[ImGuiCol_TitleBg]              = ImGui::ImVec4(0.16f, 0.16f, 0.20f, 1.00f);
    colors[ImGuiCol_TitleBgActive]        = ImGui::ImVec4(0.20f, 0.20f, 0.25f, 1.00f);
    colors[ImGuiCol_Text]                 = ImGui::ImVec4(0.95f, 0.95f, 0.95f, 1.00f);
    colors[ImGuiCol_TextDisabled]         = ImGui::ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
    colors[ImGuiCol_FrameBg]              = ImGui::ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_FrameBgHovered]       = ImGui::ImVec4(0.28f, 0.28f, 0.32f, 1.00f);
    colors[ImGuiCol_FrameBgActive]        = ImGui::ImVec4(0.35f, 0.35f, 0.40f, 1.00f);
    colors[ImGuiCol_CheckMark]            = ImGui::ImVec4(0.00f, 0.90f, 0.45f, 1.00f);
    colors[ImGuiCol_SliderGrab]           = ImGui::ImVec4(0.00f, 0.90f, 0.45f, 1.00f);
    colors[ImGuiCol_SliderGrabActive]     = ImGui::ImVec4(0.00f, 1.00f, 0.50f, 1.00f);
    colors[ImGuiCol_Button]               = ImGui::ImVec4(0.22f, 0.22f, 0.26f, 1.00f);
    colors[ImGuiCol_ButtonHovered]        = ImGui::ImVec4(0.00f, 0.75f, 0.38f, 1.00f);
    colors[ImGuiCol_ButtonActive]         = ImGui::ImVec4(0.00f, 0.60f, 0.30f, 1.00f);
}

// ==========================================
// THÀNH PHẦN 3: HÀM VẼ GIAO DIỆN MENU CHÍNH
// ==========================================
void HienThiMenuPvZ() {
    // Áp dụng bộ màu và bo góc đẹp
    SetBeautifulStyle();

    // Thiết lập kích thước menu mặc định (Rộng 420px, Cao 320px)
    ImGui::SetNextWindowSize(ImGui::ImVec2(420, 320), ImGuiCond_FirstUseEver);

    // Vẽ cửa sổ menu
    if (ImGui::Begin(" PVZ FUSION MOD MENU ", NULL, ImGuiWindowFlags_NoCollapse)) {
        
        ImGui::TextColored(ImGui::ImVec4(0.00f, 0.90f, 0.45f, 1.00f), "DEVELOPER TOOLS v1.0");
        ImGui::Separator(); 
        ImGui::Spacing();

        // Khu vực 1: Quản lý tài nguyên
        ImGui::Text(" Chức năng Tài Nguyên:");
        ImGui::Spacing();
        ImGui::Checkbox("Vô Hạn Mặt Trời (Infinite Sun)", &bInfiniteSun);
        
        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();

        // Khu vực 2: Quản lý cơ chế chơi
        ImGui::Text(" Chức năng Lối Chơi:");
        ImGui::Spacing();
        ImGui::Checkbox("Hồi Chiêu Siêu Tốc (No Cooldown)", &bNoCooldown);

        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();
        
        ImGui::TextDisabled("Hệ thống vận hành an toàn qua SideStore.");
        
        ImGui::End();
    }
}

// ==========================================
// THÀNH PHẦN 4: LIÊN KẾT VÀO VÒNG LẶP ĐỒ HỌA IOS
// ==========================================
@interface ImGuiDrawView : UIView
- (void)drawRect:(CGRect)rect;
@end

@implementation ImGuiDrawView

// Đây là hàm vòng lặp đồ họa gốc của lớp View trên iOS
- (void)drawRect:(CGRect)rect {
    // Thực hiện các lệnh vẽ nền hệ thống của template trước (giữ nguyên luồng xử lý gốc)
    [super drawRect:rect];

    // GỌI MENU HIỂN THỊ: Chèn hàm xử lý menu của bạn vào đây để nó liên tục cập nhật khung hình
    HienThiMenuPvZ();
}

@end

// ==========================================
// THÀNH PHẦN 5: KHỞI TẠO HOOK LOGIC TRÒ CHƠI
// ==========================================

// Ghi đè hàm lấy số lượng Mặt Trời
int (*old_GetSun)(void* instance);
int new_GetSun(void* instance) {
    if (bInfiniteSun) {
        return 9999; 
    }
    return old_GetSun(instance);
}

// Ghi đè hàm kiểm tra Hồi Chiêu
bool (*old_IsReady)(void* instance);
bool new_IsReady(void* instance) {
    if (bNoCooldown) {
        return true; 
    }
    return old_IsReady(instance);
}

// Hàm tự động kích hoạt khi dylib được trò chơi nạp lên bộ nhớ
__attribute__((constructor)) static void initialize() {
    // Lưu ý kỹ thuật: Điểm kết nối logic (Hook) này sẽ có hiệu lực ngay khi trò chơi chạy.
    // Địa chỉ bộ nhớ chính xác của game cần được điền tại đây khi phân tích cấu trúc thực thi.
    // Ví dụ cấu trúc đăng ký lệnh:
    // MSHookFunction((void*)(0x10000000), (void*)new_GetSun, (void**)&old_GetSun);
}
