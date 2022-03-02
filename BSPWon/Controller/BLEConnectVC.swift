//
//  BLEConnectVC.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/12.
//

import UIKit
import CoreBluetooth

class BLEConnectVC : UIViewController
{
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 15
        self.tableView.dataSource = self
        self.tableView.delegate = self
        BLEStack.shared.deviceReloadDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        BLEStack.shared.centralManager.scanForPeripherals(withServices: nil, options: nil)
        tableView.reloadData()        
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
        BLEStack.shared.peripheralArray.removeAll()
    }
}

//MARK: - TableView Delegate
extension BLEConnectVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return BLEStack.shared.peripheralArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID.deviceCell, for: indexPath)
        cell.textLabel?.text = BLEStack.shared.peripheralArray[indexPath.row].name
        return cell
    }
    
    // Connect via bluetooth when a cell is touched
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Selected a device")
        let tmpDevice = BLEStack.shared.peripheralArray[indexPath.row]
        
        BLEStack.shared.selectedUUID = tmpDevice.peripheral.identifier
        BLEStack.shared.selected = BluetoothPeriperal(name: tmpDevice.name, peripheral: tmpDevice.peripheral)
        BLEStack.shared.connectToDevice()
        
        // manipulate MainVC's content and dismiss
        guard let connectButton = BLEStack.shared.mainVC.connectButton
        else
        {
            print("cannot find previous viewcontroller")
            return
        }
        connectButton.setTitle("Disconnect", for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - Protocol - Delegate Pattern
// Update when iOS receives new peripheral data

extension BLEConnectVC : DeviceReloadDelegate
{
    func reloadView()
    {
        tableView.reloadData()
    }
}
