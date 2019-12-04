import UIKit

class BookTableViewController: UITableViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    var books = [Book]()
    var selectedBook: Book?

    //Search variables
    var filteredArray = [Book]()
    var showSearchResults = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAboutButton()
        createSearchBar()
        loadSampleBooks()
    }
    
    func createAboutButton(){
        let aboutButton = UIBarButtonItem(title: "About", style: .plain, target: self, action: #selector(aboutClicked))
        
        self.navigationItem.leftBarButtonItem = aboutButton
    }
    
    @objc func aboutClicked() {
        self.performSegue(withIdentifier: "AboutSegue", sender: self)
    }
    
    func createSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter the name of a book"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = books.filter{$0.title.lowercased().range(of: searchText.lowercased()) != nil}
        
        if searchText != "" {
            showSearchResults = true
            self.tableView.reloadData()
        } else {
            showSearchResults = false
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showSearchResults {
            return filteredArray.count
        } else {
            return books.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(showSearchResults == true) {
            selectedBook = filteredArray[indexPath.row]
        }
        else {
            selectedBook = books[indexPath.row]
        }
        self.performSegue(withIdentifier: "ARSegue", sender: self)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "BookTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BookTableViewCell else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell")
        }
        
        if showSearchResults {
            let book = filteredArray[indexPath.row]
            cell.titleLabel.text = book.title
            cell.coverImageView.image = book.cover
            cell.authorLabel.text = book.author
        } else {
            let book = books[indexPath.row]
            cell.titleLabel.text = book.title
            cell.coverImageView.image = book.cover
            cell.authorLabel.text = book.author
        }

        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ARSegue"){
            let ARVC = segue.destination as! ARViewController
            ARVC.testBook = selectedBook
        }
    }
    
    // Creates sample for testing the app manually
    private func loadSampleBooks(){
        let cover1 = UIImage(named: "book1")
        let cover2 = UIImage(named: "book2")
        let cover3 = UIImage(named: "book3")
        
        guard let book1 = Book(title: "Harry Potter", cover: cover1, author: "J. K. Rowling", edition: 5, yearPublished: 2010, videoURL: "www.google.com", resource: "HarryPotterResources") else {
            fatalError("Unable to instantiate book1")
        }
        
        guard let book2 = Book(title: "Den Lille Havfrue", cover: cover2, author: "H. C. Andersen", edition: 2, yearPublished: 2010, videoURL: "www.google.com", resource: "DenLilleHavfrueResources") else {
            fatalError("Unable to instantiate book2")
        }
        
        guard let book3 = Book(title: "Test Book", cover: cover3, author: "T. E. St", edition: 11, yearPublished: 2010, videoURL: "www.google.com", resource: "TestBookResources") else {
            fatalError("Unable to instantiate book3")
        }
        
        books += [book1, book2, book3]
    }
}
