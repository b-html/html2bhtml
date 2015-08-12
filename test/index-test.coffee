assert = require 'power-assert'
html2bhtml = require './'

describe 'index', ->
  context '(default)', ->
    it '<p></p>', ->
      html = '''
        <p></p>
      '''
      bHtml = '''
        <p
      '''
      assert html2bhtml(html) is bHtml

    it '<p></p><p></p>', ->
      html = '''
        <p></p><p></p>
      '''
      bHtml = '''
        <p
        <p
      '''
      assert html2bhtml(html) is bHtml

    it '<p></p>\\n<p></p>', ->
      html = '''
        <p></p>
        <p></p>
      '''
      bHtml = '''
        <p
        |
        <p
      '''
      assert html2bhtml(html) is bHtml

    it '<p><p></p></p>', ->
      html = '''
        <p><p></p></p>
      '''
      bHtml = '''
        <p
          <p
      '''
      assert html2bhtml(html) is bHtml

    it '<img />', ->
      html = '''
        <img />
      '''
      bHtml = '''
        </img
      '''
      assert html2bhtml(html) is bHtml

    it '<img /><img />', ->
      html = '''
        <img /><img />
      '''
      bHtml = '''
        </img
        </img
      '''
      assert html2bhtml(html) is bHtml

    it '<img />\\n<img />', ->
      html = '''
        <img />\n<img />
      '''
      bHtml = '''
        </img
        |
        </img
      '''
      assert html2bhtml(html) is bHtml

    it '<p class="foo"></p>', ->
      html = '''
        <p class="foo"></p>
      '''
      bHtml = '''
        <p
          @class foo
      '''
      assert html2bhtml(html) is bHtml

    it '<p class="foo" id="bar"></p>', ->
      html = '''
        <p class="foo" id="bar"></p>
      '''
      bHtml = '''
        <p
          @class foo
          @id bar
      '''
      assert html2bhtml(html) is bHtml

    it '<p class="foo" id="bar"><p></p></p>', ->
      html = '''
        <p class="foo" id="bar"><p></p></p>
      '''
      bHtml = '''
        <p
          @class foo
          @id bar
          <p
      '''
      assert html2bhtml(html) is bHtml

    it '<img class="foo" />', ->
      html = '''
        <img class="foo" />
      '''
      bHtml = '''
        </img
          @class foo
      '''
      assert html2bhtml(html) is bHtml

    it '<img class="foo" id="bar" />', ->
      html = '''
        <img class="foo" id="bar" />
      '''
      bHtml = '''
        </img
          @class foo
          @id bar
      '''
      assert html2bhtml(html) is bHtml

    it '<!DOCTYPE html>', ->
      html = '''
        <!DOCTYPE html>
      '''
      bHtml = '''
        ><!DOCTYPE html>
      '''
      assert html2bhtml(html) is bHtml

    it '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">', ->
      html = '''
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
      '''
      bHtml = '''
        ><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
      '''
      assert html2bhtml(html) is bHtml

    it '<!-- comment -->', ->
      html = '''
        <!-- comment -->
      '''
      bHtml = '''
        ><!-- comment -->
      '''
      assert html2bhtml(html) is bHtml

    it '<!-- comment\\ncomment -->', ->
      html = '''
        <!-- comment
        comment -->
      '''
      bHtml = '''
        ><!-- comment
        |comment -->
      '''
      assert html2bhtml(html) is bHtml

    it '<!-- comment\\n\\ncomment -->', ->
      html = '''
        <!-- comment

        comment -->
      '''
      bHtml = '''
        ><!-- comment
        |
        |comment -->
      '''
      assert html2bhtml(html) is bHtml

    it '<!--\\n-->', ->
      html = '''
        <!--
        -->
      '''
      bHtml = '''
        ><!--
        |-->
      '''
      assert html2bhtml(html) is bHtml

    it '<!--\\n\\n-->', ->
      html = '''
        <!--

        -->
      '''
      bHtml = '''
        ><!--
        |
        |-->
      '''
      assert html2bhtml(html) is bHtml

    it '<![CDATA[hoge]]>', ->
      html = '''
        <![CDATA[hoge]]>
      '''
      bHtml = '''
        ><![CDATA[hoge]]>
      '''
      assert html2bhtml(html) is bHtml

    it '<![CDATA[hoge\\nfuga]]>', ->
      html = '''
        <![CDATA[hoge
        fuga]]>
      '''
      bHtml = '''
        ><![CDATA[hoge
        |fuga]]>
      '''
      assert html2bhtml(html) is bHtml

    it '<![CDATA[hoge\\n\\n  fuga]]>', ->
      html = '''
        <![CDATA[hoge

          fuga]]>
      '''
      bHtml = '''
        ><![CDATA[hoge
        |
        |  fuga]]>
      '''
      assert html2bhtml(html) is bHtml

    it '<![CDATA[\\n]]>', ->
      html = '''
        <![CDATA[
        ]]>
      '''
      bHtml = '''
        ><![CDATA[
        |]]>
      '''
      assert html2bhtml(html) is bHtml

    it '<![CDATA[\\n\\n]]>', ->
      html = '''
        <![CDATA[

        ]]>
      '''
      bHtml = '''
        ><![CDATA[
        |
        |]]>
      '''
      assert html2bhtml(html) is bHtml

    it 'text', ->
      html = '''
        text
      '''
      bHtml = '''
        >text
      '''
      assert html2bhtml(html) is bHtml

    it 'text\\ntext', ->
      html = '''
        text
        text
      '''
      bHtml = '''
        >text
        |text
      '''
      assert html2bhtml(html) is bHtml

    it 'text\\n\\ntext', ->
      html = '''
        text

        text
      '''
      bHtml = '''
        >text
        |
        |text
      '''
      assert html2bhtml(html) is bHtml

    it '\\n', ->
      html = '\n'
      bHtml = '''
        |
      '''
      assert html2bhtml(html) is bHtml

    it '\\n\\n', ->
      html = '\n\n'
      bHtml = '''
        |
        |
      '''
      assert html2bhtml(html) is bHtml

    it '<p>\\ntext</p>', ->
      html = '''
        <p>
        text</p>
      '''
      bHtml = '''
        <p
          |text
      '''
      assert html2bhtml(html) is bHtml

    it '<p>\\ntext\\n</p>', ->
      html = '''
        <p>
        text
        </p>
      '''
      bHtml = '''
        <p
          |text
          |
      '''
      assert html2bhtml(html) is bHtml

    it '<p>\\n\\ntext</p>', ->
      html = '''
        <p>

        text</p>
      '''
      bHtml = '''
        <p
          |
          |text
      '''
      assert html2bhtml(html) is bHtml

    it '<p>\\ntext\\n  text</p>', ->
      html = '''
        <p>
        text
          text</p>
      '''
      bHtml = '''
        <p
          |text
          |  text
      '''
      assert html2bhtml(html) is bHtml

  context 'removeWhiteSpace', ->
    it '<p></p>', ->
      html = '''
        <p></p>
      '''
      bHtml = '''
        <p
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p></p><p></p>', ->
      html = '''
        <p></p><p></p>
      '''
      bHtml = '''
        <p
        <p
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p></p>\\n<p></p>', ->
      html = '''
        <p></p>
        <p></p>
      '''
      bHtml = '''
        <p
        <p
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p><p></p></p>', ->
      html = '''
        <p><p></p></p>
      '''
      bHtml = '''
        <p
          <p
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<img />', ->
      html = '''
        <img />
      '''
      bHtml = '''
        </img
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<img /><img />', ->
      html = '''
        <img /><img />
      '''
      bHtml = '''
        </img
        </img
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<img />\\n<img />', ->
      html = '''
        <img />\n<img />
      '''
      bHtml = '''
        </img
        </img
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p class="foo"></p>', ->
      html = '''
        <p class="foo"></p>
      '''
      bHtml = '''
        <p
          @class foo
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p class="foo" id="bar"></p>', ->
      html = '''
        <p class="foo" id="bar"></p>
      '''
      bHtml = '''
        <p
          @class foo
          @id bar
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p class="foo" id="bar"><p></p></p>', ->
      html = '''
        <p class="foo" id="bar"><p></p></p>
      '''
      bHtml = '''
        <p
          @class foo
          @id bar
          <p
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<img class="foo" />', ->
      html = '''
        <img class="foo" />
      '''
      bHtml = '''
        </img
          @class foo
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<img class="foo" id="bar" />', ->
      html = '''
        <img class="foo" id="bar" />
      '''
      bHtml = '''
        </img
          @class foo
          @id bar
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!DOCTYPE html>', ->
      html = '''
        <!DOCTYPE html>
      '''
      bHtml = '''
        ><!DOCTYPE html>
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">', ->
      html = '''
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
      '''
      bHtml = '''
        ><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!-- comment -->', ->
      html = '''
        <!-- comment -->
      '''
      bHtml = '''
        ><!-- comment -->
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!-- comment\\ncomment -->', ->
      html = '''
        <!-- comment
        comment -->
      '''
      bHtml = '''
        ><!-- comment
        |comment -->
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!-- comment\\n\\ncomment -->', ->
      html = '''
        <!-- comment

        comment -->
      '''
      bHtml = '''
        ><!-- comment
        |
        |comment -->
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!--\\n-->', ->
      html = '''
        <!--
        -->
      '''
      bHtml = '''
        ><!--
        |-->
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<!--\\n\\n-->', ->
      html = '''
        <!--

        -->
      '''
      bHtml = '''
        ><!--
        |
        |-->
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<![CDATA[hoge]]>', ->
      html = '''
        <![CDATA[hoge]]>
      '''
      bHtml = '''
        ><![CDATA[hoge]]>
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<![CDATA[hoge\\nfuga]]>', ->
      html = '''
        <![CDATA[hoge
        fuga]]>
      '''
      bHtml = '''
        ><![CDATA[hoge
        |fuga]]>
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<![CDATA[hoge\\n\\n  fuga]]>', ->
      html = '''
        <![CDATA[hoge

          fuga]]>
      '''
      bHtml = '''
        ><![CDATA[hoge
        |
        |  fuga]]>
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<![CDATA[\\n]]>', ->
      html = '''
        <![CDATA[
        ]]>
      '''
      bHtml = '''
        ><![CDATA[
        |]]>
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<![CDATA[\\n\\n]]>', ->
      html = '''
        <![CDATA[

        ]]>
      '''
      bHtml = '''
        ><![CDATA[
        |
        |]]>
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it 'text', ->
      html = '''
        text
      '''
      bHtml = '''
        >text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it 'text\\ntext', ->
      html = '''
        text
        text
      '''
      bHtml = '''
        >text
        |text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it 'text\\n\\ntext', ->
      html = '''
        text

        text
      '''
      bHtml = '''
        >text
        |
        |text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '\\n', ->
      html = '\n'
      bHtml = ''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '\\n\\n', ->
      html = '\n\n'
      bHtml = ''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p>\\ntext</p>', ->
      html = '''
        <p>
        text</p>
      '''
      bHtml = '''
        <p
          >text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p>\\ntext\\n</p>', ->
      html = '''
        <p>
        text
        </p>
      '''
      bHtml = '''
        <p
          >text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p>\\n\\ntext</p>', ->
      html = '''
        <p>

        text</p>
      '''
      bHtml = '''
        <p
          >text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml

    it '<p>\\ntext\\n  text</p>', ->
      html = '''
        <p>
        text
          text</p>
      '''
      bHtml = '''
        <p
          >text
          |  text
      '''
      assert html2bhtml(html, removeWhiteSpace: true) is bHtml
