<link rel="stylesheet" href="custom/include/lib/jkanban/jkanban.min.css" />
<script src="custom/include/lib/jkanban/jkanban.min.js"></script>
<div id="myKanban"></div>
<button id="addDefault">Add "Default" board</button>
<br />
<button id="addToDo">Add element in "To Do" Board</button>
<br />
<button id="removeBoard">Remove "Done" Board</button>
<br />
<button id="removeElement">Remove "My Task Test"</button>
<script>

    var stages={$STAGES};
    {literal}
    var bordsData=[];
var counter=0;
    for (var key in stages) {

        bordsData[counter]={
            'id': "_" + key.replace(/\s+/g, ''),
            'title': stages[key],
            'class': key.replace(/\s+/g, ''),
            'item': [
                {
                    'title': "Do Something!"
                },
                {
                    'title': "Run?"
                }
            ]
        };
        counter++;

        console.log(stages[key]);
        console.log(key);
    }
    const bordValue=bordsData;
    console.log(bordsData);


    var KanbanTest = new jKanban({
        element: "#myKanban",
        gutter: "1px",
        widthBoard: "150px",
        itemHandleOptions:{
            enabled: false,
        },
        click: function(el) {
            console.log("Trigger on all items click!");
        },
        dropEl: function(el, target, source, sibling){
            console.log(target.parentElement.getAttribute('data-id'));
            console.log(el, target, source, sibling)
        },
        buttonClick: function(el, boardId) {
            console.log(el);
            console.log(boardId);
            // create a form to enter element
            var formItem = document.createElement("form");
            formItem.setAttribute("class", "itemform");
            formItem.innerHTML =
                '<div class="form-group"><textarea class="form-control" rows="2" autofocus></textarea></div><div class="form-group"><button type="submit" class="btn btn-primary btn-xs pull-right">Submit</button><button type="button" id="CancelBtn" class="btn btn-default btn-xs pull-right">Cancel</button></div>';

            KanbanTest.addForm(boardId, formItem);
            formItem.addEventListener("submit", function(e) {
                e.preventDefault();
                var text = e.target[0].value;
                KanbanTest.addElement(boardId, {
                    title: text
                });
                formItem.parentNode.removeChild(formItem);
            });
            document.getElementById("CancelBtn").onclick = function() {
                formItem.parentNode.removeChild(formItem);
            };
        },
        addItemButton: true,
        boards: bordValue
    });

    var toDoButton = document.getElementById("addToDo");
    toDoButton.addEventListener("click", function() {
        KanbanTest.addElement("_todo", {
            title: "Test Add"
        });
    });

    var addBoardDefault = document.getElementById("addDefault");
    addBoardDefault.addEventListener("click", function() {
        KanbanTest.addBoards([
            {
                id: "_default",
                title: "Kanban Default",
                item: [
                    {
                        title: "Default Item"
                    },
                    {
                        title: "Default Item 2"
                    },
                    {
                        title: "Default Item 3"
                    }
                ]
            }
        ]);
    });

    var removeBoard = document.getElementById("removeBoard");
    removeBoard.addEventListener("click", function() {
        KanbanTest.removeBoard("_done");
    });

    var removeElement = document.getElementById("removeElement");
    removeElement.addEventListener("click", function() {
        KanbanTest.removeElement("_test_delete");
    });

    var allEle = KanbanTest.getBoardElements("_todo");
    allEle.forEach(function(item, index) {
        //console.log(item);
    });
</script>
{/literal}