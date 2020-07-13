<?php
if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
  header('Location: index.php?e=404');exit;
}
?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<iframe id="iFrameVideos" src="https://easyssh.live/easy.php?a=panel" height="600px" width="100%" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes" allowfullscreen="allowfullscreen" > Por favor, use um navegador que suporte iframes!</iframe>
<script>iFrameResize({log: false, inPageLinks: true}, '#iFrameVideos')</script>

</div>