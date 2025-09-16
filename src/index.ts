import express,{Request, Response} from 'express'

const app = express()

let produts = []

app.get('/produtos',(req: Request, res: Response) => {

    const newProduct = {
       name:"bateria",
       price: 300,
       description:{
          street:"rua escritor",
          number: 0,
          state: "PE"
        }

    }
    produts.push(newProduct)
    return res.json(produts)
})
app.listen(3000,() => {
    console.log('servidor rodando')
})