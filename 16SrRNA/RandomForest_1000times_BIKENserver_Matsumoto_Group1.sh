conda activate qiime2-2020.8

for i in `seq -f %03g 0 999`
do
  qiime sample-classifier regress-samples-ncv \
    --i-table table.qza \
    --m-metadata-file sample-metadata.tsv \
    --m-metadata-column Age \
    --p-estimator RandomForestRegressor \
    --p-cv 5 \
    --p-stratify \
    --p-parameter-tuning \
    --p-n-jobs $CPU_NUM \
    --o-feature-importance "$i"_feature_importance.qza \
    --o-predictions "$i"_predictions-ncv.qza
  qiime sample-classifier scatterplot \
    --i-predictions "$i"_predictions-ncv.qza \
    --m-truth-file sample-metadata.tsv \
    --m-truth-column Age \
    --o-visualization "$i"_scatter-ncv.qzv
  qiime tools export --input-path "$i"_feature_importance.qza --output-path ./
  mv importance.tsv "$i"_feature_importance.tsv
  qiime tools export --input-path "$i"_predictions-ncv.qza --output-path ./
  mv predictions.tsv "$i"_predictions-ncv.tsv
done

conda deactivate
