&&build_namespace
&&build_deployment
&&alb_name
&&ingress_group_name
&&health_port
&&health
&&port
&&account
&&region
&&build_repo
&&nodegroup_name
&&mem_request
&&cpu_request
&&cpu_limit
&&mem_limit
&&max_replica
&&min_replica


### Example 

sed -i "s|&&build_namespace|cache-auto|g" ./*.yaml
sed -i "s|&&build_deployment|cache-auto|g" ./*.yaml
sed -i "s|&&ingress_group_name|cache-auto|g" ./*.yaml
sed -i "s|&&health|/health|g" ./*.yaml
sed -i "s|&&port|3674|g" ./*.yaml
sed -i "s|&&account|696292622193|g" ./*.yaml
sed -i "s|&&region|eu-west-1|g" ./*.yaml
sed -i "s|&&nodegroup_name|pricing|g" ./*.yaml
sed -i "s|&&mem_request|1Gi|g" ./*.yaml
sed -i "s|&&cpu_request|1|g" ./*.yaml
sed -i "s|&&cpu_limit|1|g" ./*.yaml
sed -i "s|&&mem_limit|1Gi|g" ./*.yaml
sed -i "s|&&max_replica|1|g" ./*.yaml
sed -i "s|&&min_replica|1|g" ./*.yaml
sed -i "s|&&alb_name|pricing-ingress-alb|g" ./*.yaml
sed -i "s|&&health_port|3700|g" ./*.yaml
sed -i "s|&&build_repo|ttl-cache_cache_engine|g" ./*.yaml