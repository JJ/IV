package main

// taken from https://github.com/tucnak/telebot
import (

    "time"
    "os"
    "fmt"
    "strings"
	"strconv"
	"log"
    "net/http"
    "encoding/json"
    "io/ioutil"
//    "bytes"

)

type Hito struct {
	File string `json:"file"`
	Title string `json:"title"`
	Date string `json:"fecha"`
}

type Data struct {
	Comment string `json:"comment"`
	Hitos []Hito `json:"hitos"`
}

var hitos []Hito
var ahora = time.Now()
var fechas []time.Time
var hitos_data Data

func init() {

	// Load milestones array
	file, e := ioutil.ReadFile("./hitos.json")
	if e != nil {
		log.Fatal("No se puede leer fichero de hitos")
	}
	if err := json.Unmarshal(file,&hitos_data); err != nil {
		log.Fatal("Error en el JSON de hitos →", err)
	}

	for _,hito := range hitos_data.Hitos {

//		this_url := strings.Join( []string{"https://jj.github.io/IV/documentos/proyecto/",hito.File}, "/")
		d := strings.Split(hito.Date,"/")
		this_day, _ := strconv.Atoi(d[0])
		this_month, _ := strconv.Atoi(d[1])
		this_year, _ := strconv.Atoi(d[2])
		fechas = append( fechas,
			time.Date(this_year, time.Month(this_month), this_day,
				12,30,0,0, time.Local))

	}

}

func main() {
	http.HandleFunc("/", dame_hitos)
	port := os.Getenv("PORT")
	if port == "" {
		port = "31415"
	}
	bind := fmt.Sprintf(":%s", port)
	fmt.Printf("Escucha en %s...", bind)
	err := http.ListenAndServe(bind, nil)
	if err != nil {
		log.Fatal(err)
	}
}

func dame_hitos(res http.ResponseWriter, req *http.Request) {
	este_hito, _ := strconv.ParseInt(req.URL.Query().Get("hito"), 10, 64)
	js,err := json.Marshal( hitos_data.Hitos[este_hito])
	if ( err != nil ) {
		fmt.Fprintf( res, "Error %s", err )
	} else {
		res.Header().Set("Content-Type", "application/json")
		res.Write(js)
	}
}
