Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03097C74A5B
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 12:13:07 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.10497.1678968785307888402
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 05:13:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qPhRg0Vd;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id m35so1068832wms.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678968783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCBK22B2ojcfHDJmK1kMMgV0GRHR3RV8xTQxu9SafuY=;
        b=qPhRg0Vd1j9U5UQS40vcIpCjxTg3t3pKUJpWpVojk5EtcZAhGYOJ8UwIMmVGwoVPlx
         vwOUzlPPXVDz8skrpQQCn4iK18+CGIPFTIG1NnVFUA6zqRGEOqZ8sucYMXYQBb4cEOLa
         JKfnT1DjYFqVMezg39ljZILASdJjfgDF755McZw4U/iVlOiMMhPwVeZFNazvtFMzKpdj
         jK5Vbhc8iaRydCAUHgbmRrv4wYu/mC1mk3/9APjSSFZik2WZCiRlEuCRiLVE3IdLU42s
         qmKRcZJRLkzmVSCttDKm0CSOglOZmhSdSU3TDyy5M3jl6jIml9XjY1qVMo8qKPSMSlUC
         62Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCBK22B2ojcfHDJmK1kMMgV0GRHR3RV8xTQxu9SafuY=;
        b=5slp2v8tjf3FTd5WklWOnVxn3hYVlWRCYoni25Hi/u5lbK/sONbbfetKmZEreCiIP2
         o4Vs4MV9rJgeOoHXLczuydS2wtTwRh9P7XNp5LsfVv3GueAGNUhgO5AjxVBW5H0TDG3N
         lVFqGM+n+B5DHStl9IiYNdKcxOD/FB/TC6P2kot2VobNvecwG/rDXy3DvHrTMWuatZE2
         i0ZvLDI2TwFbQs94ptQqLsJzzYE7auN6tTofF/ht8ymGJw6VaxB0x9mz4s7S74+Ckrbp
         /zpga/tY9b747Nii5J/ff8RYm5QA6ProK/sxjfyXW0q5h+r++DGhRY7acArH6P72fNG0
         T/kw==
X-Gm-Message-State: AO0yUKU5tMdEgOnGKNgZYczI7/uGj/SRD6WB/5tNHZua/4gCEQIEfVCn
	uCgbJ5NuUTD9ucedp43kN+nZTjIVOPs=
X-Google-Smtp-Source: AK7set8btXc0FRHwr8wRXXqik17ePG1luqlkoqTWwuMCR/Piaw3XhKbpPqiOP2FXsj9mpll2nSkaJg==
X-Received: by 2002:a05:600c:1e01:b0:3ea:a76a:4965 with SMTP id ay1-20020a05600c1e0100b003eaa76a4965mr21167588wmb.21.1678968783435;
        Thu, 16 Mar 2023 05:13:03 -0700 (PDT)
Received: from work-pc.core.sigfox.net ([2a01:e0a:8d5:c6c0:65ad:993a:17fa:6608])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003e8dcc67bdesm5039971wms.30.2023.03.16.05.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:13:03 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [PATCH 3/3] python3-cryptography: add crates checksums
Date: Thu, 16 Mar 2023 13:12:49 +0100
Message-Id: <20230316121249.28209-3-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316121249.28209-1-frederic.martinsons@gmail.com>
References: <20230316121249.28209-1-frederic.martinsons@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 12:13:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14586

From: Frederic Martinsons <frederic.martinsons@gmail.com>

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 .../python/python3-cryptography-crates.inc    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/meta/recipes-devtools/python/python3-cryptography-crates.inc b/meta/recipes-devtools/python/python3-cryptography-crates.inc
index a0c8fa50c9..74f47897a6 100644
--- a/meta/recipes-devtools/python/python3-cryptography-crates.inc
+++ b/meta/recipes-devtools/python/python3-cryptography-crates.inc
@@ -69,3 +69,70 @@ SRC_URI += " \
     crate://crates.io/winapi-util/0.1.5 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
 "
+
+SRC_URI[Inflector.sha256sum] = "fe438c63458706e03479442743baae6c88256498e6431708f6dfc520a26515d3"
+SRC_URI[aliasable.sha256sum] = "250f629c0161ad8107cf89319e990051fae62832fd343083bea452d93e2205fd"
+SRC_URI[android_system_properties.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
+SRC_URI[asn1.sha256sum] = "2affba5e62ee09eeba078f01a00c4aed45ac4287e091298eccbb0d4802efbdc5"
+SRC_URI[asn1_derive.sha256sum] = "bfab79c195875e5aef2bd20b4c8ed8d43ef9610bcffefbbcf66f88f555cc78af"
+SRC_URI[autocfg.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
+SRC_URI[base64.sha256sum] = "9e1b586273c5702936fe7b7d6896644d8be71e6314cfe09d3167c95f712589e8"
+SRC_URI[bitflags.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[bumpalo.sha256sum] = "37ccbd214614c6783386c1af30caf03192f17891059cecc394b4fb119e363de3"
+SRC_URI[cc.sha256sum] = "a20104e2335ce8a659d6dd92a51a767a0c062599c73b343fd152cb401e828c3d"
+SRC_URI[cfg-if.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[chrono.sha256sum] = "16b0a3d9ed01224b22057780a37bb8c5dbfe1be8ba48678e7bf57ec4b385411f"
+SRC_URI[codespan-reporting.sha256sum] = "3538270d33cc669650c4b093848450d380def10c331d38c768e34cac80576e6e"
+SRC_URI[core-foundation-sys.sha256sum] = "5827cebf4670468b8772dd191856768aedcb1b0278a04f989f7766351917b9dc"
+SRC_URI[cxx.sha256sum] = "5add3fc1717409d029b20c5b6903fc0c0b02fa6741d820054f4a2efa5e5816fd"
+SRC_URI[cxx-build.sha256sum] = "b4c87959ba14bc6fbc61df77c3fcfe180fc32b93538c4f1031dd802ccb5f2ff0"
+SRC_URI[cxxbridge-flags.sha256sum] = "69a3e162fde4e594ed2b07d0f83c6c67b745e7f28ce58c6df5e6b6bef99dfb59"
+SRC_URI[cxxbridge-macro.sha256sum] = "3e7e2adeb6a0d4a282e581096b06e1791532b7d576dcde5ccd9382acf55db8e6"
+SRC_URI[iana-time-zone.sha256sum] = "64c122667b287044802d6ce17ee2ddf13207ed924c712de9a66a5814d5b64765"
+SRC_URI[iana-time-zone-haiku.sha256sum] = "0703ae284fc167426161c2e3f1da3ea71d94b21bedbcc9494e92b28e334e3dca"
+SRC_URI[indoc.sha256sum] = "47741a8bc60fb26eb8d6e0238bbb26d8575ff623fdc97b1a2c00c050b9684ed8"
+SRC_URI[indoc-impl.sha256sum] = "ce046d161f000fffde5f432a0d034d0341dc152643b2598ed5bfce44c4f3a8f0"
+SRC_URI[instant.sha256sum] = "7a5bbe824c507c5da5956355e86a746d82e0e1464f65d862cc5e71da70e94b2c"
+SRC_URI[js-sys.sha256sum] = "49409df3e3bf0856b916e2ceaca09ee28e6871cf7d9ce97a692cacfdb2a25a47"
+SRC_URI[libc.sha256sum] = "201de327520df007757c1f0adce6e827fe8562fbc28bfd9c15571c66ca1f5f79"
+SRC_URI[link-cplusplus.sha256sum] = "ecd207c9c713c34f95a097a5b029ac2ce6010530c7b49d7fea24d977dede04f5"
+SRC_URI[lock_api.sha256sum] = "435011366fe56583b16cf956f9df0095b405b82d76425bc8981c0e22e60ec4df"
+SRC_URI[log.sha256sum] = "abb12e687cfb44aa40f41fc3978ef76448f9b6038cad6aef4259d3c095a2382e"
+SRC_URI[num-integer.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
+SRC_URI[num-traits.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
+SRC_URI[once_cell.sha256sum] = "2f7254b99e31cad77da24b08ebf628882739a608578bb1bcdfc1f9c21260d7c0"
+SRC_URI[ouroboros.sha256sum] = "dfbb50b356159620db6ac971c6d5c9ab788c9cc38a6f49619fca2a27acb062ca"
+SRC_URI[ouroboros_macro.sha256sum] = "4a0d9d1a6191c4f391f87219d1ea42b23f09ee84d64763cd05ee6ea88d9f384d"
+SRC_URI[parking_lot.sha256sum] = "7d17b78036a60663b797adeaee46f5c9dfebb86948d1255007a1d6be0271ff99"
+SRC_URI[parking_lot_core.sha256sum] = "60a2cfe6f0ad2bfc16aefa463b497d5c7a5ecd44a23efa72aa342d90177356dc"
+SRC_URI[paste.sha256sum] = "45ca20c77d80be666aef2b45486da86238fabe33e38306bd3118fe4af33fa880"
+SRC_URI[paste-impl.sha256sum] = "d95a7db200b97ef370c8e6de0088252f7e0dfff7d047a28528e47456c0fc98b6"
+SRC_URI[pem.sha256sum] = "03c64931a1a212348ec4f3b4362585eca7159d0d09cbdf4a7f74f02173596fd4"
+SRC_URI[proc-macro-error.sha256sum] = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
+SRC_URI[proc-macro-error-attr.sha256sum] = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
+SRC_URI[proc-macro-hack.sha256sum] = "dc375e1527247fe1a97d8b7156678dfe7c1af2fc075c9a4db3690ecd2a148068"
+SRC_URI[proc-macro2.sha256sum] = "57a8eca9f9c4ffde41714334dee777596264c7825420f521abc92b5b5deb63a5"
+SRC_URI[pyo3.sha256sum] = "d41d50a7271e08c7c8a54cd24af5d62f73ee3a6f6a314215281ebdec421d5752"
+SRC_URI[pyo3-build-config.sha256sum] = "779239fc40b8e18bc8416d3a37d280ca9b9fb04bda54b98037bb6748595c2410"
+SRC_URI[pyo3-macros.sha256sum] = "00b247e8c664be87998d8628e86f282c25066165f1f8dda66100c48202fdb93a"
+SRC_URI[pyo3-macros-backend.sha256sum] = "5a8c2812c412e00e641d99eeb79dd478317d981d938aa60325dfa7157b607095"
+SRC_URI[quote.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
+SRC_URI[redox_syscall.sha256sum] = "fb5a58c1855b4b6819d59012155603f0b22ad30cad752600aadfcb695265519a"
+SRC_URI[scopeguard.sha256sum] = "d29ab0c6d3fc0ee92fe66e2d99f700eab17a8d57d1c1d3b748380fb20baa78cd"
+SRC_URI[scratch.sha256sum] = "ddccb15bcce173023b3fedd9436f882a0739b8dfb45e4f6b6002bee5929f61b2"
+SRC_URI[smallvec.sha256sum] = "a507befe795404456341dfab10cef66ead4c041f62b8b11bbb92bffe5d0953e0"
+SRC_URI[syn.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
+SRC_URI[termcolor.sha256sum] = "bab24d30b911b2376f3a13cc2cd443142f0c81dda04c118693e35b3835757755"
+SRC_URI[unicode-ident.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
+SRC_URI[unicode-width.sha256sum] = "c0edd1e5b14653f783770bce4a4dabb4a5108a5370a5f5d8cfe8710c361f6c8b"
+SRC_URI[unindent.sha256sum] = "e1766d682d402817b5ac4490b3c3002d91dfa0d22812f341609f97b08757359c"
+SRC_URI[version_check.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+SRC_URI[wasm-bindgen.sha256sum] = "eaf9f5aceeec8be17c128b2e93e031fb8a4d469bb9c4ae2d7dc1888b26887268"
+SRC_URI[wasm-bindgen-backend.sha256sum] = "4c8ffb332579b0557b52d268b91feab8df3615f265d5270fec2a8c95b17c1142"
+SRC_URI[wasm-bindgen-macro.sha256sum] = "052be0f94026e6cbc75cdefc9bae13fd6052cdcaf532fa6c45e7ae33a1e6c810"
+SRC_URI[wasm-bindgen-macro-support.sha256sum] = "07bc0c051dc5f23e307b13285f9d75df86bfdf816c5721e573dec1f9b8aa193c"
+SRC_URI[wasm-bindgen-shared.sha256sum] = "1c38c045535d93ec4f0b4defec448e4291638ee608530863b1e2ba115d4fff7f"
+SRC_URI[winapi.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-util.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
+SRC_URI[winapi-x86_64-pc-windows-gnu.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-- 
2.34.1


