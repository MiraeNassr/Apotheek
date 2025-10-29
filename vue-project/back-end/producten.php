<?php

// Include database configuration and get_products logic
require_once 'db_config.php';
require_once 'get_products.php';

// Function to get a display name for the category
function getCategoryDisplayName($category) {
    $map = [
        'Antihistamine' => 'Antihistamine Producten',
        'Vitaminen & Supplements' => 'Vitaminen & Supplementen',
        'Antibiotics' => 'Antibiotica Producten',
        'Pain relief' => 'Pijnverlichting Producten',
    ];
    return $map[$category] ?? 'Alle Producten';
}

$display_name = getCategoryDisplayName($category);
?>

<!DOCTYPE html>
<html lang="nl" dir="ltr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producten Overzicht</title>
    <link rel="stylesheet" href="assets/style.css">
</head>

<body>

    <div id="hoofd-app">

        <header class="top-bar">
        </header>

        <main class="main-content product-page-layout">

            <h1 id="category-title">Producten: <?php echo htmlspecialchars($display_name); ?></h1>

            <section class="product-list">

                <?php if (!empty($error_message)): ?>
                <p class="error-message"><?php echo htmlspecialchars($error_message); ?></p>
                <?php elseif (empty($products)): ?>
                <p class="no-results-message">Geen producten gevonden in de categorie
                    '<?php echo htmlspecialchars($display_name); ?>'.</p>
                <?php else: ?>
                <?php foreach ($products as $product): ?>
                <div class="product-item">
                    <div class="product-image-box">
                        <img src="<?php echo htmlspecialchars(str_replace('src/', '', $product['afbeelding_url'])); ?>"
                            alt="<?php echo htmlspecialchars($product['naam']); ?>" class="product-img">
                    </div>
                    <div class="product-details">
                        <p class="product-info-title"><?php echo htmlspecialchars($product['naam']); ?></p>
                        <p class="product-info-description"><?php echo htmlspecialchars($product['beschrijving']); ?>
                        </p>
                        <button class="add-to-cart-btn">
                            € <?php echo number_format($product['prijs'], 2, ',', '.'); ?> | Bestel
                        </button>
                    </div>
                </div>
                <?php endforeach; ?>
                <?php endif; ?>

            </section>

            <button class="chat-icon-fixed">💬</button>
        </main>

        <footer class="main-footer">
        </footer>
    </div>

</body>

</html>