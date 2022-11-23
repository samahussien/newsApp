import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/web_view_screen.dart';

Widget defaultTextFormFeild({
  required TextEditingController controller,
  VoidCallback? onSubmit(String)?,
  VoidCallback? onChange(String)?,
  VoidCallback? onTap,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  required TextInputType type,
  bool isPassword = false,
  VoidCallback? onSuffix,
  required BuildContext context,
}) 
   { 
    
    NewsCubit cubit = NewsCubit.get(context);

 return  TextFormField(
      validator: validate,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onTap: onTap,
      style: TextStyle(color: cubit.isDark? Colors.white:Colors.black),
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide( color:cubit.isDark? Colors.white:Colors.grey)),
          labelText: label,
          
          labelStyle: TextStyle(
            color: cubit.isDark? Colors.white:Colors.grey
          ),
          prefixIcon: Icon(prefix,color:cubit.isDark? Colors.white:Colors.grey),
          suffixIcon: IconButton(onPressed: onSuffix, icon: Icon(suffix,color: cubit.isDark? Colors.white:Colors.grey)),
          border: const OutlineInputBorder()),
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );}

Widget newsItem(
    {required String imageUrl,
    required String title,
    required String time,
    required String url,
    required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(
                    url: url,
                  )));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: imageUrl != "null"
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ))
                : const SizedBox(),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget screenBuilder(
    {required NewsAppStates state, required List dataList, isSearch = false}) {
  return ConditionalBuilder(
      condition: dataList.isNotEmpty,
      builder: (context) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => newsItem(
              context: context,
              url: dataList[index]['url'],
              imageUrl: dataList[index]['urlToImage'].toString(),
              time: dataList[index]['publishedAt'].toString(),
              title: dataList[index]['title']),
          itemCount: dataList.length,
          separatorBuilder: (context, index) => const Divider(),
        );
      },
      fallback: (context) =>
          isSearch ? Container() : const Center(child: const CircularProgressIndicator()));
}
