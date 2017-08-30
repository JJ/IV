package main

// taken from https://github.com/tucnak/telebot
import (

    "time"
//    "os"
    "fmt"
    "strings"
	"strconv"
	"log"
//    "net/http"
    "encoding/json"
    "io/ioutil"
    "bytes"

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
var opcionesText bytes.Buffer
var opcionesNumberText bytes.Buffer
var ahora = time.Now()
var fechas []time.Time

func init() {

	// Load milestones array
	file, e := ioutil.ReadFile("./hitos.json")
	if e != nil {
		log.Fatal("No se puede leer fichero de hitos")
	}
	var hitos_data Data
	if err := json.Unmarshal(file,&hitos_data); err != nil {
		log.Fatal("Error en el JSON de hitos →", err)
	}

	for i,hito := range hitos_data.Hitos {

		//adding opciones to choose 
		opcionesText.WriteString(strconv.Itoa(i) + "-" + hito.Title + "\r\n")
		opcionesNumberText.WriteString(strconv.Itoa(i) + "\r\n")

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
	fmt.Printf("%v", hitos)
	

}

