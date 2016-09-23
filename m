Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
	[209.85.220.67])
	by mail.openembedded.org (Postfix) with ESMTP id 6209760750
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 17:19:28 +0000 (UTC)
Received: by mail-pa0-f67.google.com with SMTP id i5so2181502pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Sep 2016 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:references:to:from:message-id:date:user-agent:mime-version
	:in-reply-to; bh=8i7NEyIrAliiF2ULZLzCYk0U6UB+/JqpUDU9jch9p0Q=;
	b=e1tB/1lhDdi+2Uvq2ZrF10ilrEx1/5Bfzws83fCCr05tG1UuVVCNXaBEBDVfMbjuYc
	zn5k9vYC1Q8IEHf95vv6lNJ34Mb/BfK626w+60SGe/Ok3Ge20duZXVGnvisrLY3Jialc
	2supBdWChge9uEEcFa/TaKTAq1qVitp3xnxtLIaDgOFH19df4aLNAovwhgws6QHKRGQM
	rked0KBZTgHdtDfegLcLi/cYkH0nCaSze7wA1VmcJZ0/qFoo93cb9TqolGNYW+0JNg5+
	We1UsLHpVGNit42u0F1L0wEhqnDd+4hMf5Tg8UQYlpo9JkKz0AZK6fokhsuo4vzH4Muf
	tPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:references:to:from:message-id:date
	:user-agent:mime-version:in-reply-to;
	bh=8i7NEyIrAliiF2ULZLzCYk0U6UB+/JqpUDU9jch9p0Q=;
	b=bOzokXFo9+IpWtpNkDQAwtyRy0opXhstXmYlrCmrqH3s9HcIqqFWkqS6H9ynp3rJRz
	HEpItPEPBQF4J6hxGHnLLIH7o7KFcMPmGy16vTOoMUReo4hsog3R2QbyrigD8TG9OfGR
	HqERog7zI2PeXZUO5FG5X7DRCVKtmo25N/LAWfAuTCYP3yPteWooRBpz5FUOqJdcBq3X
	LauSIbjdEMLjfoD/v7SyE3GLg6APNNd3qr6uCQPtGD2KwEsPPCYhedZeYHNicil88j0O
	x9LUfTOcjLoPU/xgnTML8YdDaftykNeBhxSkZ056Jah+yaFgeuIZMwChwQNXv3MmG8wt
	ts+g==
X-Gm-Message-State: AE9vXwM6pqOj6PLsFrW2A1jo/1BbNrEcVAMM0CZ4XYvkmMneo9e0mz/ZTC/v98REhMNDMg==
X-Received: by 10.66.43.230 with SMTP id z6mr14007209pal.150.1474651170674;
	Fri, 23 Sep 2016 10:19:30 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:c560:5d36:d9b:7d07?
	([2601:202:4001:9ea0:c560:5d36:d9b:7d07])
	by smtp.gmail.com with ESMTPSA id
	q25sm12913390pfj.48.2016.09.23.10.19.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Sep 2016 10:19:29 -0700 (PDT)
References: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
From: akuster808 <akuster808@gmail.com>
X-Forwarded-Message-Id: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
Message-ID: <ee245bab-9f01-c26a-baee-fab952080e79@gmail.com>
Date: Fri, 23 Sep 2016 10:19:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
Subject: [PATCH 0/3] Bitbake 1.28-next
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
X-List-Received-Date: Fri, 23 Sep 2016 17:19:29 -0000
Content-Type: multipart/alternative;
	boundary="------------FECDE8AC8AE08B6647F56621"

--------------FECDE8AC8AE08B6647F56621
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Ping?




-------- Forwarded Message --------
Subject: 	[PATCH 0/3] Bitbake 1.28-next
Date: 	Fri, 16 Sep 2016 16:36:41 -0700
From: 	Armin Kuster <akuster808@gmail.com>
To: 	bitbake-devel@lists.openembedded.org, akuster808@gmail.com



Please consider these changes for 1.28
to fix bitbake-selftest failures.


Richard Purdie (1):
   bb/tests/fetch: Update cups url

Ross Burton (2):
   lib/bb/tests/fetch: remove URL that doesn't exist anymore
   fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()

  lib/bb/fetch2/wget.py | 72 +++++++++++++++++++++++++++++++++++----------------
  lib/bb/tests/fetch.py |  7 ++---
  2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.7.4


--------------FECDE8AC8AE08B6647F56621
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=windows-1252">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Ping?</p>
    <p><br>
    </p>
    <div class="moz-forward-container"><br>
      <br>
      -------- Forwarded Message --------
      <table class="moz-email-headers-table" border="0" cellpadding="0"
        cellspacing="0">
        <tbody>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Subject:
            </th>
            <td>[PATCH 0/3] Bitbake 1.28-next</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">Date: </th>
            <td>Fri, 16 Sep 2016 16:36:41 -0700</td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">From: </th>
            <td>Armin Kuster <a class="moz-txt-link-rfc2396E" href="mailto:akuster808@gmail.com">&lt;akuster808@gmail.com&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" valign="BASELINE" nowrap="nowrap">To: </th>
            <td><a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a>,
              <a class="moz-txt-link-abbreviated" href="mailto:akuster808@gmail.com">akuster808@gmail.com</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>Please consider these changes for 1.28
to fix bitbake-selftest failures.


Richard Purdie (1):
  bb/tests/fetch: Update cups url

Ross Burton (2):
  lib/bb/tests/fetch: remove URL that doesn't exist anymore
  fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()

 lib/bb/fetch2/wget.py | 72 +++++++++++++++++++++++++++++++++++----------------
 lib/bb/tests/fetch.py |  7 ++---
 2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.7.4

</pre>
    </div>
  </body>
</html>

--------------FECDE8AC8AE08B6647F56621--
