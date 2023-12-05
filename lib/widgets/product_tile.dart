import 'package:flutter/material.dart';
import 'package:webwiders/modal/product_modal.dart';
class ProductTile extends StatefulWidget {
  final Function onAddClick;
  final Product product;
  const ProductTile({Key? key,required this.product,required this.onAddClick}) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),

      child: ListTile(

        leading: Image.network(
          widget.product.images![0],
          fit: BoxFit.fill,
          width: 70,
          height: 70,
        ),
        title: Text("${widget.product.title}",maxLines: 1,style: TextStyle(overflow: TextOverflow.ellipsis),),

        subtitle: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Per unit",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "Rs.${widget.product.price}",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              SizedBox(width: 5,),
              Column(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "0.00",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
        trailing: ElevatedButton(
            onPressed:widget.onAddClick(),
            child: Text("Add"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
      ),
    );
  }
}

