// Auto-generated from swap.html.
// DO NOT EDIT.

library x_swap;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'dart:async';
import 'dart:html';
import 'package:meta/meta.dart';
import 'package:web_ui/web_ui.dart';
import 'package:bot/bot.dart';
import 'package:widget/effects.dart';
import 'package:widget/widget.dart';



// TODO: cleaner about having requests pile up...handle the pending change cleanly

/**
 * [Swap] is a low-level component designed to be composed by other components.
 * It exposes the functionality of the [Swapper] effect as a simple container element with corresponding methods to
 * `swap` between child elements via code.
 *
 * [Tabs] and [Carousel] both use this component.
 */
class Swap extends WebComponent implements SwapComponent {
  /** Autogenerated from the template. */

  autogenerated.ScopedCssMapper _css;

  /** This field is deprecated, use getShadowRoot instead. */
  get _root => getShadowRoot("x-swap");
  static final __shadowTemplate = new autogenerated.DocumentFragment.html('''
        
        <div class="content">
          <content></content>
        </div>
      ''');
  autogenerated.Template __t;

  void created_autogenerated() {
    var __root = createShadowRoot("x-swap");
    setScopedCss("x-swap", new autogenerated.ScopedCssMapper({".prev":"prev",".content":"content",".active":"active","x-swap":"[is=\"x-swap\"]"}));
    _css = getScopedCss("x-swap");
    __t = new autogenerated.Template(__root);
    __root.nodes.add(__shadowTemplate.clone(true));
    __t.create();
  }

  void inserted_autogenerated() {
    __t.insert();
  }

  void removed_autogenerated() {
    __t.remove();
    __t = null;
  }

  /** Original code from the component. */

  static const _activeClass = 'active';
  static const _dirClassPrev = 'prev';

  // should only be accessed via the [_contentElement] property
  Element _contentElementField;

  @override
  int get activeItemIndex {
    return items.indexOf(activeItem);
  }

  @override
  Element get activeItem {
    return $(items).singleWhere((e) => e.classes.contains(_activeClass));
  }

  @override
  List<Element> get items => _contentElement.children;

  @override
  Future<bool> showItemAtIndex(int index, {ShowHideEffect effect, int duration, EffectTiming effectTiming, ShowHideEffect hideEffect}) {
    // TODO: support hide all if index == null

    final newActive = items[index];
    return showItem(newActive, effect: effect, duration: duration, effectTiming: effectTiming, hideEffect: hideEffect);
  }

  @override
  Future<bool> showItem(Element item, {ShowHideEffect effect, int duration, EffectTiming effectTiming, ShowHideEffect hideEffect}) {
    assert(items.contains(item));

    final oldActiveChild = activeItem;
    if(oldActiveChild == item) {
      return new Future<bool>.value(true);
    }

    [oldActiveChild, item].forEach((e) => e.classes.remove(_dirClassPrev));

    oldActiveChild.classes.remove(_activeClass);
    oldActiveChild.classes.add(_dirClassPrev);

    item.classes.add(_activeClass);

    return Swapper.swap(_contentElement, item, effect: effect, duration: duration, effectTiming: effectTiming, hideEffect: hideEffect)
        .whenComplete(() {
          oldActiveChild.classes.remove(_dirClassPrev);
        });
  }

  @protected
  void inserted() {
    _initialize();
  }

  @protected
  void removed() {
    _contentElementField = null;
  }

  Element get _contentElement {
    _initialize();
    return _contentElementField;
  }

  void _initialize() {
    if(_contentElementField == null) {
      _contentElementField = this.query('[is=x-swap] > .content');
      if(_contentElementField == null) {
        throw 'Could not find the content element. Either the template has changed or state was accessed too early in the component lifecycle.';
      }

      final theItems = _contentElementField.children;

      // if there are any elements, make sure one and only one is 'active'
      final activeFigures = new List<Element>.from(theItems.where((e) => e.classes.contains(_activeClass)).toList());
      if(activeFigures.length == 0) {
        if(theItems.length > 0) {
          // marke the first of the figures as active
          theItems[0].classes.add(_activeClass);
        }
      } else {
        activeFigures.sublist(1)
          .forEach((e) => e.classes.remove(_activeClass));
      }

      // A bit of a hack. Because we call Swap w/ two displayed items:
      // one marked 'prev' and one marked 'next', Swap tries to hide one of them
      // this only causes a problem when clicking right the first time, since all
      // times after, the cached ShowHideState of the item is set
      // So...we're going to walk the showHide states of all children now
      // ...and ignore the result...but just to populate the values
      theItems.forEach((f) => ShowHide.getState(f));
    }
  }
}

//# sourceMappingURL=swap.dart.map