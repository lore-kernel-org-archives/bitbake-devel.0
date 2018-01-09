Return-Path: <rjpdasilva@gmail.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 36106788F8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Jan 2018 18:09:41 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id g75so22217523wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Jan 2018 10:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-language:content-transfer-encoding;
	bh=Mt5ia74W5CYKsXk3uI5v9jF8HTOgpBk0qg16R4UZw4M=;
	b=fqQI9PY+8rS1PrQHXRsI7AFhptbZKfukkQdg4HIy/uIOyzzceDFk3T1eyiPxSUn0LE
	vKHRC5hz2AFbC+3u42C/jprABZdrY4nLKZp8mQJ8X5oov9MbbADUI0FUl8jkwIlbsFyg
	J249L7CWEFVYt+GnK1T/cM8fN7Iab3yaVNaAlyGG7jG89mp0tXdlyDvmO4Q2XRkzPGx5
	nyv3IFhWbUnFUaPYqQQLBUs5rksrJzmCbLVMrq+SwbuhgE1tgLYxvovdTnvh8JYfl1Gx
	jD5TBThrzCy4bzSFHThOreX/cE+VNsUYSLAf1zBASoPFEFOEmVKhXz03phNgdJKrRO7u
	QNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:from:subject:message-id:date:user-agent
	:mime-version:content-language:content-transfer-encoding;
	bh=Mt5ia74W5CYKsXk3uI5v9jF8HTOgpBk0qg16R4UZw4M=;
	b=qkudJgbHOl/yHfBZabf/dSEgDYfyOtcCShc4bIKlfOIMo9fgHfLtJLqAe2NBv7CiPU
	HTVb8ehBhxU4kHGf2YFJzxGV8ADhsjhAnKiG9IRijxFduM/t/LePd81h0RZhTnJlGZNm
	KNDL11bZpznNzYBjVF903YIPOkTeM/g39TZFyU0sP4B74Cb9i6BeVt00x4GcWZY6Nl3q
	T3RhgcLDrrtgjstb03oFI3fP68iLGlk0LgiZlQLXlB3NfzGcVLqgwA4ryMzyIbw0UEb5
	Twm5pCbTDxG83cik/UJNf+wJXcaFLsQTmUYsuL96xPFSPjrUKWiH/K5Wld43ixng1gQ6
	C7Fw==
X-Gm-Message-State: AKGB3mIm3nXRrNdz5AhWLhxpejO+tmGzyPKTHxpgGYT9RMF+Z/buUaHj
	dummT4zYqTKMLO3RVYCQtmF2YQ==
X-Google-Smtp-Source: ACJfBosV1pblW1ropfH7KXQ/8h2hp0uzSyqUNKq35jtyhoBTEhoSmtljBP/nT+N8+h8jhiLVbKZ+vA==
X-Received: by 10.28.94.5 with SMTP id s5mr13289778wmb.92.1515521382638;
	Tue, 09 Jan 2018 10:09:42 -0800 (PST)
Received: from ?IPv6:2001:8a0:6606:9100:7f03:4efc:e311:2e44?
	([2001:8a0:6606:9100:7f03:4efc:e311:2e44])
	by smtp.googlemail.com with ESMTPSA id
	90sm15254248wrp.39.2018.01.09.10.09.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Jan 2018 10:09:41 -0800 (PST)
To: bitbake-devel@lists.openembedded.org
From: Ricardo Silva <rjpdasilva@gmail.com>
Message-ID: <b06c9e62-9747-a6f6-5859-1d1958ff932f@gmail.com>
Date: Tue, 9 Jan 2018 18:09:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
Subject: Issue with "_remove" override and variables
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 09 Jan 2018 18:09:42 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi All,

In order to reduce the final image size, I want to remove some unneeded runtime
dependencies from some python3 packages, since I know that I won't be needing
them and they have a big impact on the image size.

My idea was to add a bbappend file to my layer in order to remove the
dependencies I want from the base recipe.

The base recipe has runtime dependencies like:

    RDEPENDS_${PN} += " \
        ${PYTHON_PN}-email \
        ${PYTHON_PN}-json \
        ${PYTHON_PN}-ndg-httpsclient \
        ${PYTHON_PN}-netserver \
        ${PYTHON_PN}-pyasn1 \
        ${PYTHON_PN}-pyopenssl \
        ${PYTHON_PN}-pysocks \
        ${PYTHON_PN}-urllib3 \
    "

Imagine I would like to remove the dependency from pyopenssl. I would add a
bbappend file in my layer for the base recipe and use, e.g.:

    RDEPENDS_${PN}_remove = "${PYTHON_PN}-pyopenssl"

I observe that this is not working as I was expecting, as the pyopenssl package
still gets installed, and there's no other package that depends on it. In fact,
if I just fully override RDEPENDS in the bbappend file to:

    RDEPENDS_${PN} = " \
        ${PYTHON_PN}-email \
        ${PYTHON_PN}-json \
        ${PYTHON_PN}-ndg-httpsclient \
        ${PYTHON_PN}-netserver \
        ${PYTHON_PN}-pyasn1 \
        ${PYTHON_PN}-pysocks \
        ${PYTHON_PN}-urllib3 \
    "

i.e., to have all dependencies of the base recipe except the one I want to
remove, it does work.

I think this might be related to variable expansion, because if I change the
base recipe's RDEPENDS to the following, the RDEPENDS_${PN}_remove does work:

    RDEPENDS_${PN} += " \
        ${PYTHON_PN}-email \
        ${PYTHON_PN}-json \
        ${PYTHON_PN}-ndg-httpsclient \
        ${PYTHON_PN}-netserver \
        ${PYTHON_PN}-pyasn1 \
        python3-pyopenssl \
        ${PYTHON_PN}-pysocks \
        ${PYTHON_PN}-urllib3 \
    "

I've tried checking the parsing of RDEPENDS by using `bitbake -e` on the
relevant recipe and I do notice some differences between the 3 cases:

(1) Base recipe only, no bbappend file for removing pyopenssl:

    # $RDEPENDS_python3-requests
    #   rename from RDEPENDS_${PN} data.py:116 [expandKeys]
    #     " ${@['', '${PYTHON_PN}-core']['${CLASSOVERRIDE}' == 'class-target']}      ${PYTHON_PN}-email     ${PYTHON_PN}-json     ${PYTHON_PN}-ndg-httpsclient     ${PYTHON_PN}-netserver     ${PYTHON_PN}-pyasn1     ${PYTHON_PN}-pyopenssl     ${PYTHON_PN}-pysocks     ${PYTHON_PN}-urllib3  ${PYTHON_PN}-misc"
    RDEPENDS_python3-requests=" python3-core      python3-email     python3-json     python3-ndg-httpsclient     python3-netserver     python3-pyasn1     python3-pyopenssl     python3-pysocks     python3-urllib3  python3-misc"

    Note that pyopenssl appears on last 2 lines.

(2) With RDEPENDS_${PN}_remove failing to remove pyopenssl:

    # $RDEPENDS_python3-requests
    #   rename from RDEPENDS_${PN} data.py:116 [expandKeys]
    #     "${@['', '${PYTHON_PN}-core']['${CLASSOVERRIDE}' == 'class-target']} ${PYTHON_PN}-email ${PYTHON_PN}-json ${PYTHON_PN}-ndg-httpsclient ${PYTHON_PN}-netserver ${PYTHON_PN}-pyasn1 ${PYTHON_PN}-pyopenssl ${PYTHON_PN}-pysocks ${PYTHON_PN}-urllib3 ${PYTHON_PN}-misc"
    RDEPENDS_python3-requests="python3-core python3-email python3-json python3-ndg-httpsclient python3-netserver python3-pyasn1 python3-pysocks python3-urllib3 python3-misc"

    Note that pyopenssl now appears only on the line before last.

(3) With RDEPENDS_${PN}_remove succeeding to remove pyopenssl (because base
    recipe was changed to have "python3-pyopenssl" instead of
    "${PYTHON_PN}-pyopenssl"):

    # $RDEPENDS_python3-requests
    #   rename from RDEPENDS_${PN} data.py:116 [expandKeys]
    #     "${@['', '${PYTHON_PN}-core']['${CLASSOVERRIDE}' == 'class-target']} ${PYTHON_PN}-email ${PYTHON_PN}-json ${PYTHON_PN}-ndg-httpsclient ${PYTHON_PN}-netserver ${PYTHON_PN}-pyasn1 ${PYTHON_PN}-pysocks ${PYTHON_PN}-urllib3 ${PYTHON_PN}-misc"
    RDEPENDS_python3-requests="python3-core python3-email python3-json python3-ndg-httpsclient python3-netserver python3-pyasn1 python3-pysocks python3-urllib3 python3-misc"

    Note now that there's no reference at all to pyopenssl.

I guess this is most likely some misuse on my side of variables attribution
(immediate vs deferred, etc), but from the documentation and other similar
examples I've searched out there, I could not yet find what's wrong, so any help
would be highly appreciated.

I'm running bitbake "BitBake Build Tool Core version 1.34.0" in commit
ca9b9ffc250e ("toaster: allow dots in user path names").

I've found a similar issue being described in the bitbake-devel list archives
and stackoverflow [1], but I don't think it's the same issue, because I have
already the fix for the described problem and in my case the problem is when a
variable is used in the text to be replaced, not in the text to replace.

[1] https://stackoverflow.com/questions/35336111/bitbake-override-style-removal-with-variable-expansion

Thanks in advance,

Ricardo Silva

