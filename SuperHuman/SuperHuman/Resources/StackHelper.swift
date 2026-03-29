import Foundation
import UIKit

struct StackHelper {
    
    static func rebuildStatsStack(from state: [String: Int], statsStackView: UIStackView, whereMake: String) {
        statsStackView.arrangedSubviews.forEach { v in
            statsStackView.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
        
        for (key, value) in state.sorted(by: { $0.key < $1.key }) {
            statsStackView.addArrangedSubview(makeStatRow(name: key, value: value, whereMake: whereMake))
        }
    }
    
    private static func makeStatRow(name: String, value: Int, whereMake: String) -> UIStackView {
        let keyLabel = UILabel()
        keyLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        keyLabel.textColor = UIColor.white.withAlphaComponent(0.38)
        keyLabel.text = whereMake == "Detail" ? name : "\(name.prefix(3))"
        keyLabel.numberOfLines = 2
        keyLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        valueLabel.textColor = .white
        valueLabel.text = "\(value)"
        valueLabel.textAlignment = .right
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let row = UIStackView(arrangedSubviews: [valueLabel, keyLabel])
        row.axis = .horizontal
        row.alignment = .firstBaseline
        row.spacing = whereMake == "Detail" ? 16 : 8
        row.distribution = .fill
        
        return row
    }
}
