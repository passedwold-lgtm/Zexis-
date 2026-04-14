
#import "Esp/ImGuiDrawView.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#define ICON_FA_COG u8"\uf013"
#define ICON_FA_EXTRA u8"\uf067"
#include <iostream>
#include <UIKit/UIKit.h>
#include <vector>
#include "iconcpp.h"
#import "pthread.h"
#include <array>
#include <cmath>
#include <deque>
#include <fstream>
#include <algorithm>
#include <string>
#include <sstream>
#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <cerrno>
#include <cctype>
// Imgui library
#import "JRMemory.framework/Headers/MemScan.h"
#import "Esp/CaptainHook.h"
#import "Esp/ImGuiDrawView.h"
#import "IMGUI/imgui.h"
#import "IMGUI/imgui_internal.h"
#import "IMGUI/imgui_impl_metal.h"
#import "IMGUI/zzz.h"
#include "oxorany/oxorany_include.h"
#import "Helper/Mem.h"
#include "font.h"
#import "Esp/Includes.h"
#import "Helper/Vector3.h"
#import "Helper/Vector2.h"
#import "Helper/Quaternion.h"
#import "Helper/Monostring.h"
#import <Foundation/Foundation.h>
#include "Helper/font.h"
#include "Helper/data.h"
#include "ban.cpp"
ImFont* verdana_smol;
ImFont* pixel_big = {};
ImFont* pixel_smol = {};
#include "Helper/Obfuscate.h"
#import "Helper/Hooks.h"
#import "IMGUI/zzz.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include <unistd.h>
#include <string.h>
#include "hook/hook.h"
ImVec4 userColor = ImVec4(1.0f, 0.0f, 0.0f, 1.0f);
#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define UIColorFromHex(hexColor) [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1.0]
UIWindow *mainWindow;
UIButton *menuView;
// Ghost Mode Variables


@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation ImGuiDrawView
ImFont *_espFont;
ImFont* verdanab;
ImFont* icons;
ImFont* interb;
ImFont* Urbanist;
static bool MenDeal = true;
BOOL hasGhostBeenDrawn = NO;
static bool StreamerMode = true;
bool fakeLagEnabled = false;
bool FastReloadEnabled = true;
bool SpeeeX2Enabled = false;
bool NoRecoilEnabled = false;
bool WallGlowEnabled = false;
bool WallFlyEnabled = false;
bool WallHackEnabled = false;
bool ScopeEnabled = false;
bool BypassEnabled = true;
bool antiban(void *instance) {
    return false;
}

- (void)toggleSpeedX2:(BOOL)enable {
    static dispatch_once_t onceToken;
    static vector<void*> results;
    
    JRMemoryEngine *engine = new JRMemoryEngine(mach_task_self());
    AddrRange range = {0x100000000, 0x200000000};
    
    if (enable) {
        dispatch_once(&onceToken, ^{
            uint64_t search = 4397530849764387586;
            engine->JRScanMemory(range, &search, JR_Search_Type_ULong);
            results = engine->getAllResults();
        });
        
        uint64_t modify = 4366458311853765201;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_ULong);
        }
    } else {
        uint64_t modify = 4397530849764387586; // Original value
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_ULong);
        }
        onceToken = 0;
        results.clear();
    }
    delete engine;
}

- (void)toggleNoRecoil:(BOOL)enable {
    static dispatch_once_t onceToken;
    static vector<void*> results;
    
    JRMemoryEngine *engine = new JRMemoryEngine(mach_task_self());
    AddrRange range = {0x100000000, 0x160000000};
    
    if (enable) {
        dispatch_once(&onceToken, ^{
            uint32_t search = 1016018816; // Original value to search for
            engine->JRScanMemory(range, &search, JR_Search_Type_UInt);
            results = engine->getAllResults();
        });
        
        uint32_t modify = 180; // New value to write
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_UInt);
        }
    } else {
        uint32_t modify = 1016018816; // Original value to restore
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_UInt);
        }
        onceToken = 0;
        results.clear();
    }
    delete engine;
}

- (void)toggleWallGlow:(BOOL)enable {
    static dispatch_once_t onceToken;
    static vector<void*> results;
    
    JRMemoryEngine *engine = new JRMemoryEngine(mach_task_self());
    AddrRange range = {0x100000000, 0x160000000};
    
    if (enable) {
        dispatch_once(&onceToken, ^{
            float search = 1.22f;
            engine->JRScanMemory(range, &search, JR_Search_Type_Float);
            results = engine->getAllResults();
        });

        
        float modify = 965.0f;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
    } else {
        float modify = 1.22f;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
        onceToken = 0;
        results.clear();
    }
    delete engine;
}



- (void)toggleWallFly:(BOOL)enable {
    static dispatch_once_t onceToken;
    static vector<void*> results;
    
    JRMemoryEngine *engine = new JRMemoryEngine(mach_task_self());
    AddrRange range = {0x100000000, 0x160000000};
    
    if (enable) {
        dispatch_once(&onceToken, ^{
            float search = 1.5f;
            engine->JRScanMemory(range, &search, JR_Search_Type_Float);
            results = engine->getAllResults();
        });
        
        float modify = 900.0f;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
    } else {
        float modify = 1.5f;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
        onceToken = 0;
        results.clear();
    }
    delete engine;
}

- (void)toggleWallHack:(BOOL)enable {
    static dispatch_once_t onceToken;
    static vector<void*> results;
    
    JRMemoryEngine *engine = new JRMemoryEngine(mach_task_self());
    AddrRange range = {0x100000000, 0x160000000};
    
    if (enable) {
        dispatch_once(&onceToken, ^{
            float search = 2;
            engine->JRScanMemory(range, &search, JR_Search_Type_Float);
            float search1 = 0.10000000149;
            engine->JRNearBySearch(0x20, &search1, JR_Search_Type_Float);
            float search2 = 3;
            engine->JRScanMemory(range, &search2, JR_Search_Type_Float);
            float search3 = 4.2038954e-45;
            engine->JRScanMemory(range, &search3, JR_Search_Type_Float);
            float search4 = 4.2038954e-45;
            engine->JRNearBySearch(0x20, &search4, JR_Search_Type_Float);
            results = engine->getAllResults();
        });
        
        float modify = -99;
        float modify1 = -1;
        float modify2 = -999;
        float modify3 = 1.3998972e-42;
        float modify4 = 1.3998972e-42;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
    } else {
        // Note: Original values not provided in the original code
        // You would need to restore the original values here
        onceToken = 0;
        results.clear();
    }
    delete engine;
}

- (void)toggleScope:(BOOL)enable {
    static dispatch_once_t onceToken;
    static vector<void*> results;
    
    JRMemoryEngine *engine = new JRMemoryEngine(mach_task_self());
    AddrRange range = {0x100000000, 0x160000000};
    
    if (enable) {
        dispatch_once(&onceToken, ^{
            float search = 0.03f;
            engine->JRScanMemory(range, &search, JR_Search_Type_Float);
            results = engine->getAllResults();
        });
        
        float modify = 10.0f;
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
    } else {
        float modify = 0.03f; // Original value
        for(int i = 0; i < results.size(); i++) {
            engine->JRWriteMemory((unsigned long long)(results[i]), &modify, JR_Search_Type_Float);
        }
        onceToken = 0;
        results.clear();
    }
    delete engine;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
   ImGuiStyle& style = ImGui::GetStyle();

// Texto branco
style.Colors[ImGuiCol_Text]         = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
style.Colors[ImGuiCol_TextDisabled] = ImVec4(0.60f, 0.60f, 0.60f, 1.00f);

// Fundo escuro tipo #1C2D48
ImVec4 darkBlue = ImVec4(0.11f, 0.18f, 0.28f, 1.00f);
ImVec4 darkBlueHover = ImVec4(0.15f, 0.25f, 0.40f, 1.00f);
ImVec4 darkBlueActive = ImVec4(0.20f, 0.30f, 0.50f, 1.00f);

// Aplicar nas principais áreas
style.Colors[ImGuiCol_WindowBg] = ImVec4(0.0f, 0.0f, 0.0f, 1.0f); // preto absoluto
style.Colors[ImGuiCol_ChildBg]  = ImVec4(0.0f, 0.0f, 0.0f, 1.0f); // preto absoluto
style.Colors[ImGuiCol_PopupBg]  = ImVec4(0.0f, 0.0f, 0.0f, 1.0f); // preto absoluto

style.Colors[ImGuiCol_Button]                 = ImVec4(darkBlue.x, darkBlue.y, darkBlue.z, 0.80f);
style.Colors[ImGuiCol_ButtonHovered]          = darkBlueHover;
style.Colors[ImGuiCol_ButtonActive]           = darkBlueActive;

style.Colors[ImGuiCol_FrameBg]        = ImVec4(0.12f, 0.12f, 0.12f, 0.54f); // cinza escuro
style.Colors[ImGuiCol_FrameBgHovered] = ImVec4(0.20f, 0.20f, 0.20f, 0.60f); // um pouco mais claro
style.Colors[ImGuiCol_FrameBgActive]  = ImVec4(0.25f, 0.25f, 0.25f, 0.67f); // ligeiramente mais claro que hover

style.Colors[ImGuiCol_TitleBg]                = darkBlue;
style.Colors[ImGuiCol_TitleBgActive]          = darkBlueHover;
style.Colors[ImGuiCol_TitleBgCollapsed]       = darkBlue;

style.Colors[ImGuiCol_Header]                 = darkBlue;
style.Colors[ImGuiCol_HeaderHovered]          = darkBlueHover;
style.Colors[ImGuiCol_HeaderActive]           = darkBlueActive;

style.Colors[ImGuiCol_Tab]                    = darkBlue;
style.Colors[ImGuiCol_TabHovered]             = darkBlueHover;
style.Colors[ImGuiCol_TabActive]              = darkBlueActive;

style.Colors[ImGuiCol_ScrollbarBg]            = darkBlue;
style.Colors[ImGuiCol_ScrollbarGrab]          = darkBlueHover;
style.Colors[ImGuiCol_ScrollbarGrabHovered]   = darkBlueActive;
style.Colors[ImGuiCol_ScrollbarGrabActive]    = darkBlueActive;

style.Colors[ImGuiCol_CheckMark]              = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
style.Colors[ImGuiCol_SliderGrab]             = darkBlueHover;
style.Colors[ImGuiCol_SliderGrabActive]       = darkBlueActive;

// Arredondamento dos elementos
style.FrameRounding = 10.0f;
// Arredondamento dos botões e frames
style.FrameRounding = 10.0f;


style.WindowRounding = 5.0f;
style.ChildRounding = 5.0f;
style.FrameRounding = 5.0f;
style.GrabRounding = 5.0f;
style.PopupRounding = 5.0f;
style.ScrollbarRounding = 5.0f;
style.TabRounding = 5.0f;

// Border sizes
style.WindowBorderSize = 1.0f;
style.FrameBorderSize = 1.0f;
style.PopupBorderSize = 1.0f;

// Spacing
style.WindowPadding = ImVec2(10.0f, 8.0f);
style.FramePadding = ImVec2(12.0f, 4.0f);
style.ItemSpacing = ImVec2(6.0f, 2.0f);












    static const ImWchar icons_ranges[] = { 0xf000, 0xf3ff, 0 };
    ImFontConfig icons_config;
    ImFontConfig CustomFont;
    CustomFont.FontDataOwnedByAtlas = false;
    icons_config.MergeMode = true;
    icons_config.PixelSnapH = true;
    io.Fonts->AddFontFromMemoryTTF(const_cast<std::uint8_t*>(Custom), sizeof(Custom), 21.f, &CustomFont);
    io.Fonts->AddFontFromMemoryCompressedTTF(font_awesome_data, font_awesome_size, 19.0f, &icons_config, icons_ranges);
    io.Fonts->AddFontDefault();
    ImFont* font = io.Fonts->AddFontFromMemoryTTF(sansbold, sizeof(sansbold), 21.0f, NULL, io.Fonts->GetGlyphRangesCyrillic());
    verdana_smol = io.Fonts->AddFontFromMemoryTTF(verdana, sizeof verdana, 40, NULL, io.Fonts->GetGlyphRangesCyrillic());
    pixel_big = io.Fonts->AddFontFromMemoryTTF((void*)smallestpixel, sizeof smallestpixel, 400, NULL, io.Fonts->GetGlyphRangesCyrillic());
    pixel_smol = io.Fonts->AddFontFromMemoryTTF((void*)smallestpixel, sizeof smallestpixel, 10*2, NULL, io.Fonts->GetGlyphRangesCyrillic());
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open {
    MenDeal = open;
}

+ (BOOL)isMenuShowing {
    return MenDeal;
}

- (MTKView *)mtkView {
    return (MTKView *)self.view;
}

- (void)loadView
{
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
    self.mtkView.clipsToBounds = YES;
}
#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}




// أضف قبل drawInMTKView

#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.nativeScale ?: UIScreen.mainScreen.nativeScale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);



    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
        
    hideRecordTextfield.secureTextEntry = StreamerMode;

    if (MenDeal == true) 
    {
        [self.view setUserInteractionEnabled:YES];
        [self.view.superview setUserInteractionEnabled:YES];
        [menuTouchView setUserInteractionEnabled:YES];
    } 
    else if (MenDeal == false) 
    {
        [self.view setUserInteractionEnabled:NO];
        [self.view.superview setUserInteractionEnabled:NO];
        [menuTouchView setUserInteractionEnabled:NO];
    }

    MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil) 
    {
        id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:@"ImGui Jane"];

        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
        ImGui::NewFrame();
        ImGuiStyle& style = ImGui::GetStyle();
        ImFont* font = ImGui::GetFont();
        font->Scale = 16.f / font->FontSize;
        
        CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 340) / 2;
        CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 250) / 2;

ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(340, 250), ImGuiCond_FirstUseEver);

        
        if (MenDeal == true)
        {
            ImGui::SetNextWindowSize(ImVec2(400, 240), ImGuiCond_Always); // Aumentar o tamanho da janela para acomodar as colunas
            ImGui::Begin(ENCRYPT("                                 FFH4X - LIMA CHEATS"), &MenDeal, ImGuiWindowFlags_NoResize);
            
            ImGui::Columns(2, "MainColumns", false); // Duas colunas
            ImGui::SetColumnWidth(0, 80.0f); // Largura da coluna da esquerda
            ImGui::SetCursorPosY(ImGui::GetCursorPosY() + 5); // Espaço adicional

            static int selected_tab = 0; // 0 for AIM, 1 for ESP, 2 for MISC

            // Coluna da esquerda (navegação)
            ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(0, 8));
            ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(0, 6));

            if (ImGui::Button(ICON_FA_CROSSHAIRS " ", ImVec2(-1, 40))) {
                selected_tab = 0;
            }
            if (ImGui::Button(ICON_FA_EYE " ", ImVec2(-1, 40))) {
                selected_tab = 1;
            }
            if (ImGui::Button(ICON_FA_COG " ", ImVec2(-1, 40))) {
                selected_tab = 2;
            }
            if (ImGui::Button(ICON_FA_ADDRESS_CARD " ", ImVec2(-1, 40))) {
    selected_tab = 3; // nova aba INFO
}

            ImGui::PopStyleVar(2);

            ImGui::NextColumn(); // Mover para a segunda coluna

            // Coluna da direita (conteúdo da aba selecionada)
            ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(0, 5));
            ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(0, 5));

            if (selected_tab == 0) {
                // Conteúdo da aba AIM

                
                ImGui::Checkbox("Ativar Aimbot", &Vars.Aimbot);

                float textWidth = ImGui::CalcTextSize("Exibir FOV").x;
float firstCheckboxWidth = ImGui::GetItemRectSize().x;  // Largura do primeiro checkbox
float spacing = ImGui::GetStyle().ItemSpacing.x;

// Posição X = posição atual + largura do primeiro checkbox + espaçamento
ImGui::SameLine(firstCheckboxWidth + 30.0f); // 20 pixels de espaçamento
ImGui::Checkbox("Exibir FOV", &Vars.fovaimglow);
                ImGui::Checkbox("Ignorar Deitado", &Vars.IgnoreKnocked);

float firstCheckboxWidth2 = ImGui::GetItemRectSize().x;
    ImGui::SameLine(firstCheckboxWidth2 + 20.0f);
    ImGui::Checkbox("Ignorar Paredes", &Vars.VisibleCheck);

                ImGui::PushItemWidth(210);
                ImGui::Combo(ICON_FA_CROSSHAIRS, &Vars.AimWhen, Vars.dir, 4);
                ImGui::Combo(ICON_FA_EXTRA, &Vars.AimHitbox, Vars.aimHitboxes, 3);
                ImGui::SliderFloat("Regular Fov", &Vars.AimFov, 0.00f, 500.00f, "[ %.1f ]", ImGuiSliderFlags_None);
                ImGui::PopItemWidth();
            } else if (selected_tab == 1) {
                // Conteúdo da aba ESP

                ImGui::Columns(2, "ESPColumns", false);
                ImGui::Checkbox("Ativar ESP", &Vars.Enable);

                // Calcula a posição para o segundo checkbox
float textWidth = ImGui::CalcTextSize("Esconder Painel").x;
float firstCheckboxWidth = ImGui::GetItemRectSize().x;  // Largura do primeiro checkbox
float spacing = ImGui::GetStyle().ItemSpacing.x;

// Posição X = posição atual + largura do primeiro checkbox + espaçamento
ImGui::SameLine(firstCheckboxWidth + 20.0f); // 20 pixels de espaçamento
ImGui::Checkbox("Esconder Painel", &StreamerMode);

// Agora todo o resto vem abaixo dos dois
                ImGui::Checkbox("ESP Linha", &Vars.lines);
                ImGui::Checkbox("ESP Nome", &Vars.Name);
                ImGui::Checkbox("ESP Caixa", &Vars.Box);
                ImGui::Checkbox("ESP Esqueleto", &Vars.skeleton);
                ImGui::Checkbox("ESP Vida", &Vars.Health);

                

            } else if (selected_tab == 2) {
                // Conteúdo da aba MISC
    ImGui::ColorEdit4(ENCRYPT("Cor do Painel"), (float*)&userColor, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoTooltip | ImGuiColorEditFlags_NoSidePreview | ImGuiColorEditFlags_PickerHueBar);
    ImGuiStyle& style = ImGui::GetStyle();

    style.Colors[ImGuiCol_CheckMark] = userColor;
    style.Colors[ImGuiCol_SliderGrab] = userColor;
    style.Colors[ImGuiCol_SliderGrabActive] = userColor;

    style.Colors[ImGuiCol_TitleBg] = userColor;
    style.Colors[ImGuiCol_TitleBgActive] = userColor;
    style.Colors[ImGuiCol_TitleBgCollapsed] = userColor;
    style.Colors[ImGuiCol_Separator] = userColor;

    style.Colors[ImGuiCol_Button] = userColor;
    style.Colors[ImGuiCol_ButtonHovered] = userColor;
    style.Colors[ImGuiCol_ButtonActive] = userColor;

    style.Colors[ImGuiCol_Tab] = userColor;
    style.Colors[ImGuiCol_TabHovered] = userColor;
    style.Colors[ImGuiCol_TabActive] = userColor;
    style.Colors[ImGuiCol_TabUnfocusedActive] = userColor;

    style.Colors[ImGuiCol_Header] = userColor;
    style.Colors[ImGuiCol_HeaderHovered] = userColor;
    style.Colors[ImGuiCol_HeaderActive] = userColor;

    style.Colors[ImGuiCol_NavHighlight] = userColor;
    style.Colors[ImGuiCol_TextSelectedBg] = userColor;
    style.Colors[ImGuiCol_ScrollbarBg] = userColor;
    style.Colors[ImGuiCol_ScrollbarGrab] = userColor;
    style.Colors[ImGuiCol_ScrollbarGrabHovered] = userColor;
    style.Colors[ImGuiCol_ScrollbarGrabActive] = userColor;

                if (ImGui::Button("Fix Login", ImVec2(95, 30))) {
                    self.mtkView.hidden = YES;
                    MenDeal = NO;
                    timer(30) {
                        self.mtkView.hidden = NO;
                        MenDeal = YES;
                    });
                }           
                if (ImGui::Checkbox("Speed (Beta)", &SpeeeX2Enabled)) {
                    [self toggleSpeedX2:SpeeeX2Enabled];
                }
                ImGui::SameLine();
                ImGui::TextDisabled("");
                if (ImGui::IsItemHovered())
                    ImGui::SetTooltip("");
                if (ImGui::Checkbox("No Recoil", &NoRecoilEnabled)) {
                    [self toggleNoRecoil:NoRecoilEnabled];
                }
                ImGui::SameLine();
                ImGui::TextDisabled("");
                if (ImGui::IsItemHovered())
                    ImGui::SetTooltip("");
                ImGui::Checkbox("Destruir Hack (BYPASS)", &BypassEnabled);
            }
else if (selected_tab == 3) {
                // Conteúdo da aba INFO
                ImGui::Text("Versão: 2.111.1");
                ImGui::Text("Developer: LIMA CHEATS");
                ImGui::Text("Data de Criação: 16/08/2025");
            }

            ImGui::PopStyleVar(2);
            ImGui::Columns(1); // Resetar colunas
            ImGui::End();
        }
        
        ImDrawList* draw_list = ImGui::GetBackgroundDrawList();
        get_players();
        aimbot();
        game_sdk->init();
        
        if (Vars.AimFov > 0) {
            Vars.isAimFov = true;
            ImVec2 center = ImVec2(ImGui::GetIO().DisplaySize.x / 2, ImGui::GetIO().DisplaySize.y / 2);
            
            if (Vars.fovaimglow) {
                static float rainbowHue = 0.0f;
                rainbowHue += ImGui::GetIO().DeltaTime * 0.8f;
                if (rainbowHue > 1.0f) rainbowHue = 0.0f;
                
                drawcircleglow(
                    draw_list,
                    center,
                    Vars.AimFov,
                    ImColor::HSV(rainbowHue, 0.8f, 1.0f),
                    100,
                    2.0f,
                    12
                );
            } else {
                draw_list->AddCircle(
                    center,
                    Vars.AimFov,
                    ImColor(1.0f, 0.0f, 0.0f, 0.7f),
                    100,
                    2.0f
                );
            }
        } else {
            Vars.isAimFov = false;
        }

        ImGui::Render();
        ImDrawData* draw_data = ImGui::GetDrawData();
        ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
        [commandBuffer commit];
    } 
} 

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size {}
void hooking() {
void* address[] = {
               (void*)getRealOffset(ENCRYPTOFFSET("0x102D86DE4"))
    };
    void* function[] = {
                (void*)antiban                                                     
    };
            hook(address, function, 1);
}
void *hack_thread(void *) {

    sleep(5);
    hooking();
    pthread_exit(nullptr);
    return nullptr;
}

void __attribute__((constructor)) initialize() {
    pthread_t hacks;
    pthread_create(&hacks, NULL, hack_thread, NULL); 
}
@end


