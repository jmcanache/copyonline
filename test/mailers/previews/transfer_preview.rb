# Preview all emails at http://localhost:3000/rails/mailers/transfer
class TransferPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/transfer/transfer_info
  def transfer_info
    Transfer.transfer_info
  end

end
