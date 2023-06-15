package eStoreProduct.ProductsService;

import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import eStoreProduct.model.Product;

public class BLLClass {
	int prdqty;
	HashMap<Integer, Integer> hmfixprice = new HashMap<Integer, Integer>();

	HashMap<Integer, Integer> hm = new HashMap<Integer, Integer>();
	HashMap<Integer, Integer> hmprice = new HashMap<Integer, Integer>();

	public int calcartp(List<Product> p) {
		int cartpcost = 0;

		for (Product pr : p) {
			if (hmprice.containsKey(pr.getId())) {
				hmprice.put(pr.getId(), (int) pr.getPrice());
				hmfixprice.put(pr.getId(), (int) pr.getPrice());
				hm.put(pr.getId(), 1);

				cartpcost += pr.getPrice();
			} else {
				hmprice.put(pr.getId(), (int) pr.getPrice());
				hmfixprice.put(pr.getId(), (int) pr.getPrice());
				hm.put(pr.getId(), 1);

				cartpcost += pr.getPrice();

			}
		}
		return cartpcost;

	}

	public void updateQty(int pid, int qty) {
		if (hm.containsKey(pid)) {

			if (hmprice.containsKey(pid)) {
				int p = hmfixprice.get(pid);
				System.out.println("before:" + p);
				p = p * qty;
				System.out.println("After:" + p);

				hmprice.put(pid, p);
			}

			hm.put(pid, qty);
		} else {
			if (hmprice.containsKey(pid)) {
				int p = hmfixprice.get(pid);
				System.out.println("before:==" + qty);

				p = p * qty;
				System.out.println("After:" + p);

				hmprice.put(pid, p);
			}
			hm.put(pid, qty);
		}

	}

	public int getupdateprice() {
		int upprice = 0;
		for (Entry<Integer, Integer> e : hmprice.entrySet()) {
			upprice += e.getValue();
		}
		return upprice;
	}

	public void remove(int p) {
		hm.remove(p);
		hmprice.remove(p);
	}

	public HashMap<Integer, Integer> getItemsqty() {
		return hm;
	}

	public HashMap<Integer, Integer> gethmprice() {
		return hmprice;
	}

}
