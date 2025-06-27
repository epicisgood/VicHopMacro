document.addEventListener('contextmenu', event => event.preventDefault());

function ahkButtonClick(ele) {
  ahk.ButtonClick.Func(ele);
}

function ahkSave(ele) {
  ahk.Save.Func(ele);
}



function onSaveClick() {
  const cfg = {
    url:                   document.getElementById('url').value,
    discordID:             document.getElementById('discordID').value,
    MoveSpeed:             document.getElementById('MoveSpeed').value,
    Stockings:             +document.getElementById('Stockings').checked,
    Feast:                 +document.getElementById('Feast').checked,
    Candles:               +document.getElementById('Candles').checked,
    Samovar:               +document.getElementById('Samovar').checked,
    LidArt:                +document.getElementById('LidArt').checked,
  };

  ahkSave(JSON.stringify(cfg))
  console.log(cfg)
}



function applySettings(a) {
  const s = a.data
  console.log(s)
  document.getElementById('url').value       = s.url;
  document.getElementById('discordID').value = s.discordID;
  document.getElementById('MoveSpeed').value   = s.MoveSpeed;
  document.getElementById('Stockings').checked   = !!+s.Stockings;
  document.getElementById('Feast').checked   =    !!+s.Feast;
  document.getElementById('Candles').checked   = !!+s.Candles;
  document.getElementById('Samovar').checked   = !!+s.Samovar;
  document.getElementById('LidArt').checked   = !!+s.LidArt;
  
}


function switchTab(tabId) {
  document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
  document.getElementById(tabId).classList.add('active');
}


document.querySelectorAll('.tabs button').forEach(button => {
  button.addEventListener('click', function() {
    document.querySelectorAll('.tabs button').forEach(btn => {
      btn.classList.remove('tab-button-active');
    });
    this.classList.add('tab-button-active');
  });
});

// Set da first tab active cool thing 
document.addEventListener('DOMContentLoaded', function() {
  document.querySelector('.tabs button').classList.add('tab-button-active');
});



























// DropDown JS 



 document.addEventListener("DOMContentLoaded", () => {
    window.chrome.webview.addEventListener('message', applySettings);
  })

document.querySelectorAll('.custom-dropdown').forEach(dropdown => {
  const selected = dropdown.querySelector('.custom-dropdown-selected');
  const options = dropdown.querySelector('.custom-dropdown-options');
  const hiddenInput = document.getElementById('hiddenSelector');

  selected.addEventListener('click', () => {
    options.style.display = options.style.display === 'block' ? 'none' : 'block';
  });

  options.querySelectorAll('[data-value]').forEach(option => {
    option.addEventListener('click', () => {
      const value = option.getAttribute('data-value');
      selected.textContent = option.textContent;
      hiddenInput.value = value;
      options.style.display = 'none';
    });
  });

  document.addEventListener('click', e => {
    if (!dropdown.contains(e.target)) {
      options.style.display = 'none';
    }
  });
});


document.querySelectorAll('.custom-dropdown-options div[data-value]').forEach(option => {
  option.addEventListener('click', function () {
    const selected = this.closest('.custom-dropdown').querySelector('.custom-dropdown-selected');
    const selectedKey = selected.getAttribute('data-value');

    const hiddenInput = document.querySelector(`input[type="hidden"][data-value="${selectedKey}"]`);

    const value = this.getAttribute('data-value');
    const text = this.textContent.trim();

    if (hiddenInput) {
      hiddenInput.value = value;
    }

    const img = this.querySelector('img');
    if (img) {
      const newImg = img.cloneNode(true);
      selected.innerHTML = ''; 
      selected.appendChild(newImg);
      selected.append(' ' + text);
    } else {
      selected.textContent = text;
    }
  });
});






function selectDropdownValueByData(value) {
  const option = document.querySelector(`.custom-dropdown-options div[data-value="${value}"]`);
  if (!option) return;

  const dropdown = option.closest('.custom-dropdown');
  const selected = dropdown.querySelector('.custom-dropdown-selected');
  const hiddenInput = document.getElementById('hiddenSelector');
  const text = option.textContent.trim();

  hiddenInput.value = value;

  const img = option.querySelector('img');
  if (img) {
    const newImg = img.cloneNode(true);
    selected.innerHTML = '';
    selected.appendChild(newImg);
    selected.append(' ' + text);
  } else {
    selected.textContent = text;
  }

  dropdown.querySelector('.custom-dropdown-options').style.display = 'none';
}
