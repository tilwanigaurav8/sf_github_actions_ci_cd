import { LightningElement, wire } from 'lwc';
import getPurchaseOrderList from '@salesforce/apex/ShoppingCartController.getPurchaseOrderData';
import getProductData from '@salesforce/apex/ShoppingCartController.getProductData';
import createOrder from '@salesforce/apex/ShoppingCartController.createOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ShoppingCart extends LightningElement {
    currentDate;
    invoiceNo;
    //Purchse Order Data
    totalOrderData;
    visiblePurchaseOrderData;

    //Product Data
    totalProductData;
    visibleProductData;

    selectedProductRows = [];
    

    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;

    showProducts = false;           // To show the products table
    showCart = false;              // To show the cart table
    showInvoice = false;      // To show the Invoice table
    showPurchaseOrders = true;   // To show the purchase orders table

    //Search Bar variable for product search
    queryTerm;

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        const isBlankQuery = evt.target.value === '';
        const filterData = [];
        if (isEnterKey && !isBlankQuery) {
            this.queryTerm = evt.target.value;
            console.log(this.queryTerm);
            totalProductData.forEach(product => {
                console.log('inside for');
                
                if (product.Name.includes(queryTerm)) {
                    console.log('inside for if');
                    filterData.push(product);
                }
            })

        
            console.log('filterData: ' + filterData);
            
            this.visibleProductData = filterData;
        }

    }

    handleQtyChange(event){
        this.cartColumns[3].value=event.target.value;
    }

    columns = [
        { label: 'PO Id', fieldName: 'Id', type : 'Id'},
        { label: 'Status', fieldName: 'Status__c', type: 'text', sortable: true},
        { label: 'Order Total', fieldName: 'Order_Total__c',type: 'number', sortable: true},
    ];

    productColumns = [
        { label: 'Product Name', fieldName: 'Name', type: 'text', sortable: true},
        { label: 'Price', fieldName: 'Cost__c',type: 'number', sortable: true},
        { label: 'Product Code', fieldName: 'ProductCode'},
        { label: 'Availability', fieldName: 'Availability__c',type: 'number', sortable: true},
    ];

    cartColumns = [
        { label: 'Product Name', fieldName: 'Name', type: 'text', sortable: true},
        { label: 'Price', fieldName: 'Cost__c',type: 'number', sortable: true},
        { label: 'Product Code', fieldName: 'ProductCode'},
        { label: 'Unit', fieldName: 'Unit__c',type: 'number', sortable: true, editable:true},
        {
            type: "button", label: 'Delete', initialWidth: 110, typeAttributes: {
                label: 'Delete',
                name: 'Delete',
                title: 'Delete',
                disabled: false,
                value: 'delete',
                iconPosition: 'left',
                iconName:'utility:delete',
                variant:'destructive'
            }
        }
    ];

    invoiceColumns = [
        { label: 'Product Name', fieldName: 'Name', type: 'text', sortable: true},
        { label: 'Price', fieldName: 'Cost__c',type: 'number', sortable: true},
        { label: 'Product Code', fieldName: 'ProductCode'},
        { label: 'Unit', fieldName: 'Unit__c',type: 'number', sortable: true}
    ]

    @wire(getPurchaseOrderList)
    wireOrderData({error, data}){
        if(data){ 
            this.totalOrderData = data
            console.log(this.totalOrderData)
        }
        if(error){
            console.error(error)
        }
    }

    @wire(getProductData)
    wireProductData({error, data}){
        if(data){
            this.totalProductData = data
            console.log(this.totalProductData)
        }
        if(error){
            console.error(error)
        }
    }

    updatePurchaseOrderHandler(event){
        this.visiblePurchaseOrderData=[...event.detail.records]
        console.log(event.detail.records)
    }

    updateProductHandler(event){
        this.visibleProductData=[...event.detail.records];
        console.log(event.detail.records)
    }

    
    // Used to sort the column
    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.visiblePurchaseOrderData];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.visiblePurchaseOrderData = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }



    getSelectedName(event) {
        
        this.selectedProductRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        console.log('You selected: ' + JSON.stringify(this.selectedProductRows));
        
    }

    addNewPurcheseOrder(){
        this.showProducts=true;
        this.showPurchaseOrders=false;

    }

    goToCart(){
        const temp=this.selectedProductRows;
        console.log('Inside cart1--'+JSON.stringify(this.selectedProductRows));
        this.selectedProductRows= temp.map(row => ({
            ...row,
            unit: 1
        }));

        console.log(temp);
        console.log('Inside cart--'+JSON.stringify(this.selectedProductRows));

        var today = new Date();
        this.currentDate=today.toISOString();
        console.log(today.toISOString());
        
        this.invoiceNo =  Math. floor(Math. random() * (10000000000));
        
        this.showProducts=false;
        this.showCart=true;
    }

    checkOut(){
        this.showCart=false;
        this.showInvoice=true;

        this.selectedProductRows= this.selectedProductRows.map(row => ({
            ...row,
            total: ((row.Cost__c === null && row.Cost__c) <= 0? 0 : row.Cost__c) *  row.Unit__c
        }));

        console.log('Inside Checkout--'+JSON.stringify(this.selectedProductRows));
    }

    findRowIndexById(id) {
        let ret = -1;
        this.selectedProductRows.some((row, index) => {
            if (row.Id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

    handleRowAction(event){

        const action = event.detail.action;
        const row = event.detail.row;
        


        console.log(action.name);
        console.log(row.Id);
        console.log(row);

        const index = this.findRowIndexById(row.Id);

        console.log('Index--'+index);
        

        if (index !== -1) {
            console.log('before cahnge--'+this.selectedProductRows);
            
            this.selectedProductRows = this.selectedProductRows
                .slice(0, index)
                .concat(this.selectedProductRows.slice(index + 1));
        }

        console.log('after cahnge--'+this.selectedProductRows);
        
    }

    placeOrder(){
        console.log('Place Order');
        console.log(this.selectedProductRows);

        createOrder({selectedRows:JSON.stringify(this.selectedProductRows)}).then(result => {
            console.log(result);
            const evt = new ShowToastEvent({
                title: 'Order created',
                message: 'Record ID: ' +result,
                variant: 'success',
            });
            this.dispatchEvent(evt);
            
            this.showInvoice=false;
            this.showPurchaseOrders = true;
        }).catch(error => {
            console.log(error);
            const evt = new ShowToastEvent({
                title: 'Order not created',
                message: 'Error: ' +error,
                variant: 'error'
            });
            this.dispatchEvent(evt);
        });

    }
}