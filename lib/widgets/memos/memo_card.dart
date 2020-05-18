import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../models/memo.dart';
import '../../resources/realtime_data.dart';

class MemoCard extends StatefulWidget {
  final memo;
  final Function insertIntoList;
  final Function deleteFromList;

  MemoCard({
    @required this.memo,
    @required this.insertIntoList,
    @required this.deleteFromList,
  });

  @override
  _MemoCardState createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  GlobalKey<FormState> __globalKey = GlobalKey<FormState>();
  bool _hiddenContainer = false;
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _titleFocus = FocusNode();
  String _title, _data;

  @override
  Widget build(BuildContext context) {
    return widget.memo.runtimeType == Memo
        ? Dismissible(
            onDismissed: (removedMemo) => memos.removeAt(
              memos.indexWhere((mymemo) => widget.memo == mymemo),
            ),
            key: UniqueKey(),
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF9a1f40),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  const Text(
                    'Delete memo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: const Color(0xFFC6D7C4),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                height: 120.0,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.memo.title,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          DateFormat("dd|MM|yyyy").format(widget.memo.date),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 57.0,
                      child: Text(
                        widget.memo.data,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color(0xff7da37a),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              height: 241.0,
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: __globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              color: Colors.white38,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _title = value;
                                  });
                                },
                                cursorColor: Colors.teal,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Title cannot be empty";
                                  else
                                    return null;
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _titleFocus,
                                onFieldSubmitted: (value) =>
                                    _descriptionFocus.nextFocus(),
                                decoration: InputDecoration(
                                  hintText: 'Enter title',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                      width: 2.0,
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          DateFormat("dd|MM|yyyy").format(DateTime.now()),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: _hiddenContainer ? 91 : 113.0,
                        padding: const EdgeInsets.all(5.0),
                        color: Colors.white38,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _data = value;
                            });
                          },
                          focusNode: _descriptionFocus,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Give a short description";
                            else
                              return null;
                          },
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            hintText: 'Enter a brief description',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2.0,
                              ),
                            ),
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    _hiddenContainer
                        ? const SizedBox(height: 20.0)
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 40.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     widget.deleteFromList();
                          //     addingListItem = false;
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: const Color(0xFF9a1f40),
                          //     ),
                          //     child: Icon(
                          //       Icons.close,
                          //       size: 30.0,
                          //       color: Colors.white,
                          //     ),
                          //     padding: const EdgeInsets.all(2.0),
                          //   ),
                          // ),
                          const SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              if (__globalKey.currentState.validate()) {
                                widget.insertIntoList(
                                  position: 0,
                                  memo: Memo(
                                    title: _title,
                                    date: DateTime.now(),
                                    data: _data,
                                  ),
                                );

                                myMemos.add(
                                  Memo(
                                    title: _title,
                                    date: DateTime.now(),
                                    data: _data,
                                  ),
                                );
                              } else
                                setState(() {
                                  _hiddenContainer = false;
                                });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff8cba51),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(2.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
