<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xf="http://www.w3.org/2002/xforms"
                exclude-result-prefixes="xf">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html lang="uk">
            <head>
                <meta charset="UTF-8"/>
                <title>Babik Nikita Petrovych lab 4</title>
                <link rel="stylesheet" href="styles.css" type="text/css"/>
                <script>
                    function handleSubmit(event) {
                    event.preventDefault();
                    const form = document.getElementById("libraryForm");
                    const formData = new FormData(form);
                    console.log("Форма відправлена з даними:", Object.fromEntries(formData));
                    alert("Дані збережено! Перегляньте консоль для деталей.");
                    form.reset();
                    }

                    function handleReset() {
                    document.getElementById("libraryForm").reset();
                    }
                </script>
            </head>
            <body>
                <h2>Запис до бібліотеки</h2>
                <form id="libraryForm" onsubmit="handleSubmit(event)">
                    <div class="form-group">
                        <xsl:apply-templates select="//xf:group/xf:*[not(self::xf:submit or self::xf:trigger)]"/>
                        <div class="button-group">
                            <input type="submit" value="Записатись"/>
                            <input type="button" value="Очистити" onclick="handleReset()"/>
                        </div>
                    </div>
                </form>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="xf:input">
        <div class="input-group">
            <label for="{generate-id()}" class="label">
                <xsl:value-of select="xf:label"/>
            </label>
            <input type="text" id="{generate-id()}" name="{substring-after(@ref, '/registration/')}" required="required"/>
        </div>
    </xsl:template>

    <xsl:template match="xf:select1">
        <div class="input-group">
            <label class="label">
                <xsl:value-of select="xf:label"/>
            </label>
            <div class="radio-group">
                <xsl:apply-templates select="xf:item"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="xf:item">
        <input type="radio" id="{generate-id()}" name="{substring-after(../@ref, '/registration/')}" value="{xf:value}" required="required">
            <xsl:if test="position() = 1">
                <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
        </input>
        <label for="{generate-id()}">
            <xsl:value-of select="xf:label"/>
        </label><br/>
    </xsl:template>

    <xsl:template match="xf:submission|xf:model|xf:instance|xf:action|xf:rebuild|xf:recalculate|xf:refresh|xf:reset"/>
</xsl:stylesheet>