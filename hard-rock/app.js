const searchSongs = async() => {
  const searchText = document.getElementById("search-field").value;
  console.log(searchText);
const url = `https://api.lyrics.ovh/suggest/${searchText}`
//load data
const res =  await fetch(url);
const data = await res.json();
displaySongs(data.data);
.catch(error => )
}

const displaySongs = songs => {
  const songContainer = document.getElementById("song-container");
songContainer.innerHTML = "";
songs.forEach(song =>{

  const songDiv = document.createElement('div');
  songDiv.className = "single-result row align-items-center my-3 p-3";
  songDiv.innerHTML = `
   <div class="col-md-9">
                        <h3 class="lyrics-name">${song.title}</h3>
                        <p class="author lead">Album by <span>${song.artist.name}</span></p>
                          <audio controls> 
                          <source src="${song.preview}" type= "audio/mpeg">
                          </audio>
                    </div>
                    <div class="col-md-3 text-md-right text-center">
                        <button onclick="getLyric('${song.artist.name}', '${song.title}')" class="btn btn-success">Get Lyrics</button>
                    </div>`;
  songContainer.appendChild(songDiv);
}) 
}
const getLyric = async (artist, title)=>{
  const url = `https://api.lyrics.ovh/v1/${artist}/${title}`;
 const res = await fetch(url);
 const data = await res.json();
 displayLyrics(data.lyrics);
}
const displayLyrics = lyrics => {
  const lyricsDiv = document.getElementById("song-lyrics");
  lyricsDiv.innerText = lyrics;
}