Return-Path: <openembedded-devel@urbanec.net>
X-Greylist: delayed 599 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Jun 2015 13:10:01 UTC
Received: from mail14.tpgi.com.au (smtp-out14.tpgi.com.au [220.244.226.124])
	by mail.openembedded.org (Postfix) with ESMTP id 3164D7568B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 13:10:01 +0000 (UTC)
X-TPG-Junk-Status: Message not scanned
X-TPG-Antivirus: Passed
X-TPG-Abuse: host=60-242-171-118.static.tpgi.com.au; ip=60.242.171.118;
	date=Mon, 15 Jun 2015 22:53:49 +1000
Received: from gw.urbanec.net (60-242-171-118.static.tpgi.com.au
	[60.242.171.118])
	by mail14.tpgi.com.au (envelope-from openembedded-devel@urbanec.net)
	(8.14.3/8.14.3) with ESMTP id t5FCrl9b000642
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 22:53:49 +1000
Received: from beep.urbanec.net ([192.168.42.2]) by gw.urbanec.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.85)
	(envelope-from <openembedded-devel@urbanec.net>) id 1Z4Tta-0004pG-QP
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Jun 2015 22:53:46 +1000
Message-ID: <557ECADA.8080509@urbanec.net>
Date: Mon, 15 Jun 2015 22:53:46 +1000
From: Peter Urbanec <openembedded-devel@urbanec.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: prserv nohist mode is broken - suggested fix included
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
X-List-Received-Date: Mon, 15 Jun 2015 13:10:04 -0000
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    I've run into a strange problem where in some cases package version
    numbers would roll back. Eventually I tracked the issue to prserv
    apparently not doing the right thing when running in the default
    nohist mode.<br>
    <br>
    As a simple example, I have this in PRMAIN_nohist:<br>
    <br>
    <code> version</code><code>                 pkgarch   
      checksum                             value<br>
------------------------------------------------------------------------------<br>
    </code><code>"beyonwiz-base-1.3-r0"    "all"   
      "d87bfea4ce066ec8b6041a8d3188956b"    "43"
</code><code><br>
    </code><code>"beyonwiz-base-1.3-r0"    "all"   
      "bba78fccad5b1b5ec9841a4002bd0252"    "42"
</code><code><br>
    </code><br>
    I think the problem is the primary key used for the nohist table. It
    should not include the checksum column.<br>
    <br>
    <code>PRMAIN_nohist</code> should be created only with  <code>PRIMARY
      KEY(version,pkgarch)</code><br>
    <br>
    To fix up an existing database, the following SQL code can be used:<br>
    <br>
    <code>CREATE TABLE PRMAIN_nohist2 (`version`    TEXT NOT NULL,   
      `pkgarch`    TEXT NOT NULL,    `checksum`    TEXT NOT NULL,   
      `value`    INTEGER,    PRIMARY KEY(version,pkgarch));</code><code><br>
    </code><code>insert or replace into PRMAIN_nohist2 (version,
      pkgarch, checksum, value) select version, pkgarch, checksum, value
      from PRMAIN_nohist order by value;</code><code><br>
    </code><code>drop table PRMAIN_nohist ;</code><code><br>
    </code><code>alter table PRMAIN_nohist2 rename to PRMAIN_nohist ;</code><code><br>
    </code><br>
    <br>
    Cheers,<br>
    <br>
        Peter<br>
    <br>
  </body>
</html>

