#include "DictationTestApp.h"
#include "cinder/Log.h"

using namespace ci;
using namespace ci::app;
using namespace std;

// Set to 0 to observe crash caused by dictation destroying the OpenGL context.
#define FIX_CRASH_ON_DICTATION 1
#include "RootViewController.h"

RootViewController *ROOT_VIEW_CONTROLLER;

inline void prepareSettings(App::Settings *settings)
{
    ROOT_VIEW_CONTROLLER = [[RootViewController alloc] init];
    
    settings->setFrameRate(30.0f);
    settings->prepareWindow(Window::Format().rootViewController(ROOT_VIEW_CONTROLLER));
}


void DictationTestApp::setup()
{
    // Tell native view to show us
    [ROOT_VIEW_CONTROLLER addCinderViewToFront];

    _font = gl::TextureFont::create(Font("Avenir-Medium", 32.0f));
}

void DictationTestApp::update()
{
}

void DictationTestApp::draw()
{
    auto print_error = [] (const std::string &where) {
        auto err = gl::getError();
        if (err) {
            CI_LOG_E("OpenGL Error " << where << ": " << gl::getErrorString(err));
        }
    };
    print_error("Before draw");

#if FIX_CRASH_ON_DICTATION
    // Forcing the context to be current fixes the crash caused by using dictation.
    gl::context()->makeCurrent(true);
#endif

    // If we don't force the context to be current, sanity check discovers that the
    // array buffer bindings don't match Cinder's expectations and will crash the application.
    // Disable this check to receive the gpus_ReturnGuiltyForHardwareRestart error later.
    gl::context()->sanityCheck();

	gl::clear( Color( 0, 0, 0 ) );
    gl::setMatricesWindowPersp(getWindowSize());

    _font->drawString(_text, vec2(200));

    gl::ScopedModelMatrix matrix;
    gl::ScopedDepth depth_scope(true);
    gl::translate(getWindowCenter());
    gl::rotate(normalize(glm::angleAxis<float>(getElapsedSeconds(), vec3(0.1f, 0.3f, 0.7f))));
    gl::drawColorCube(vec3(0), vec3(100.0f));

    // After dictation, there will be GL_INVALID_OPERATION errors from our previous OpenGL calls.
    print_error("After draw");
}

CINDER_APP( DictationTestApp, RendererGl, prepareSettings )
