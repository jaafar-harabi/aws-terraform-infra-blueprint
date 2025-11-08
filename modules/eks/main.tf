variable "name"       { type = string }
variable "subnet_ids" { type = list(string) }

resource "aws_iam_role" "eks" {
  name = "${var.name}-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect="Allow",
      Principal={ Service="eks.amazonaws.com" },
      Action="sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_attach" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "this" {
  name     = "${var.name}-eks"
  role_arn = aws_iam_role.eks.arn
  vpc_config { subnet_ids = var.subnet_ids }
}

output "cluster_name" { value = aws_eks_cluster.this.name }
