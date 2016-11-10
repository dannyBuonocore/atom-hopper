'use babel';

import AtomHopperView from './atom-hopper-view';
import { CompositeDisposable } from 'atom';

export default {

  atomHopperView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.atomHopperView = new AtomHopperView(state.atomHopperViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.atomHopperView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-hopper:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.atomHopperView.destroy();
  },

  serialize() {
    return {
      atomHopperViewState: this.atomHopperView.serialize()
    };
  },

  toggle() {
    console.log('AtomHopper was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
