#include "cinder/app/App.h"
#include "cinder/app/RendererGl.h"
#include "cinder/gl/gl.h"

///
/// Testing text input on tvos.
/// Demonstrates fix for issue with dictation breaking the current OpenGL context.
/// Note that typing text into the text field does not break the OpenGL context.
///
class DictationTestApp : public ci::app::App {
public:
    void setup() override;
    void update() override;
    void draw() override;

    void setText(const std::string &text) { _text = text; }
private:
    ci::gl::TextureFontRef _font;
    std::string            _text = "Hello";
};
