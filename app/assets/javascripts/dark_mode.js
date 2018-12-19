document.body.style.backgroundColor = sessionStorage.getItem('bg');
document.body.style.color = sessionStorage.getItem('qq');

document.h1.style.color = sessionStorage.getItem('ww');




function darker() {
     if ( sessionStorage.getItem('bg') === 'white') {
         
            sessionStorage.setItem('bg', 'rgb(6, 23, 37)');
            sessionStorage.setItem('qq', 'white');

            sessionStorage.setItem('ww', 'white');
            document.getElementById("tbl").className = "table table-hover table-darker";
         
     }
    else if (sessionStorage.getItem('bg') == null || undefined) {
        sessionStorage.setItem('bg', 'rgb(6, 23, 37)');
        sessionStorage.setItem('qq', 'white');

        sessionStorage.setItem('ww', 'white');
        document.getElementById("tbl").className = "table table-hover table-darker";
        
    }
    else if( sessionStorage.getItem('bg') === 'rgb(6, 23, 37)') {
        
        sessionStorage.setItem('bg', 'white');
        sessionStorage.setItem('qq', '#333');
        
        sessionStorage.setItem('ww', 'black');

        document.getElementById("tbl").className = "table table-hover";
        
  
    }

document.body.style.backgroundColor = sessionStorage.getItem('bg');
document.body.style.color = sessionStorage.getItem('qq');
document.h1.style.color = sessionStorage.getItem('ww');


}