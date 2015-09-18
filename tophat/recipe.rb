class Tophat < FPM::Cookery::Recipe
  description 'Tophat is a fast splice junction mapper for RNA-Seq reads.'
  name 'tophat'
  version '1.4.1' 
  revision 0
  homepage 'http://ccb.jhu.edu/software/tophat/index.shtml'
  source "https://ccb.jhu.edu/software/tophat/downloads/tophat-#{version}.Linux_x86_64.tar.gz"
  md5 'f4a3243551c8a5a19b7a1ff115c18447'

  build_depends ['curl']
  
  def build
  end

  def install
    bin.install ['bam2fastx', 'bam_merge', 'bed_to_juncs', 'closure_juncs', 'contig_to_chr_coords', 'extract_reads', 'fix_map_ordering', 'gtf_juncs', 'gtf_to_fasta', 'juncs_db', 'library_stats', 'long_spanning_reads', 'map2gtf', 'mask_sam', 'prep_reads', 'sam_juncs', 'segment_juncs', 'sra_to_solid', 'tophat', 'tophat_reports', 'wiggles']
  end
end
