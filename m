Return-Path: <A.Baumfalk@astro-kom.de>
Received: from mailrelay-out1.netcologne.de (mailrelay-out1.netcologne.de
	[81.173.193.131])
	by mail.openembedded.org (Postfix) with ESMTP id 025856007A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 09:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mailrelay-out1.netcologne.de (Postfix) with ESMTP id 8D19210AFFB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 10:46:58 +0100 (CET)
Received: from [213.196.222.82] (helo=mailrelay-out1.netcologne.de)
	by localhost with ESMTP (eXpurgate 4.3.1)
	(envelope-from <A.Baumfalk@astro-kom.de>)
	id 5a8a9d12-5654-7f0000012729-7f0000019165-1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 10:46:58 +0100
Received: from ASTRO-EX1.Bensberg.de (unknown [213.196.222.82])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailrelay-out1.netcologne.de (Postfix) with ESMTPS
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 10:46:58 +0100 (CET)
Received: from [192.168.8.2] (192.168.100.114) by ASTRO-EX1.Bensberg.de
	(192.168.100.26) with Microsoft SMTP Server (TLS) id 15.0.775.38;
	Mon, 19 Feb 2018 10:46:58 +0100
From: Arno Baumfalk <a.baumfalk@astro-kom.de>
To: <bitbake-devel@lists.openembedded.org>
References: <a2f951c8-72a9-49a8-362b-a176577f351a@astro-kom.de>
Message-ID: <0892eb5f-5b52-0e09-6bde-84fa8bda55f1@astro-kom.de>
Date: Mon, 19 Feb 2018 10:46:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a2f951c8-72a9-49a8-362b-a176577f351a@astro-kom.de>
X-Originating-IP: [192.168.100.114]
X-ClientProxiedBy: ASTRO-EX1.Bensberg.de (192.168.100.26) To
	ASTRO-EX1.Bensberg.de (192.168.100.26)
X-purgate-ID: 153929::1519033618-00005654-73A52267/0/0
X-purgate: clean
Subject: Re: exception in checksum.py
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
X-List-Received-Date: Mon, 19 Feb 2018 09:46:58 -0000
Content-Type: multipart/alternative;
	boundary="------------CBF03BC7784A21A3C61C5552"
Content-Language: de-DE

--------------CBF03BC7784A21A3C61C5552
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'd like to add two more things:

1) For all recipes which use the custom gitsmlocal fetcher AND have at 
least one additional local file in the SOURCE_URI, such as:
SRC_URI = "gitsmlocal://foo \
file://file1 \
file://file2 \
file://file3"
a warning is issued for each of the local files:
/path/to/recipe/foo/foo_1.0.bb: Unable to get checksum for foo SRC_URI 
entry foo_file: file1 could not be found
/path/to/recipe/foo/foo_1.0.bb: Unable to get checksum for foo SRC_URI 
entry foo_file: file2 could not be found
/path/to/recipe/foo/foo_1.0.bb: Unable to get checksum for foo SRC_URI 
entry foo_file: file3 could not be found

 From debugging the code I figured, that bitbake seems to expect this 
file in the yocto-download cache, but it is not there. Instead, I found 
file1.done, file2.done and file3.done in the download cache.

I am not sure if this is somehow related to the original problem, but I 
thought I should mention it here just in case.

2) I tried to debug the bitbake run using the python debugger. I 
debugged on the krogroth branch, where described problem occured for the 
first time. I was analyzing the difference between the git fetcher and 
my custom fetcher. What I found was, that my fetcher was not properly 
initialized (urldata_init was not called) until the exception was thrown 
while the git fetcher was.
I tried to find out where the init call came from and found, that for 
the git fetcher the function "get_srcrev" was called, while for my 
custom fetcher it was not. This is where a Fetch object is initilalized 
which in turn calls the urldata_init function.
Maybe this helps to find the root cause of my problem?


Arno

--------------CBF03BC7784A21A3C61C5552
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hi,<br>
    </p>
    I'd like to add two more things:<br>
    <br>
    1) For all recipes which use the custom gitsmlocal fetcher AND have
    at least one additional local file in the SOURCE_URI, such as:<br>
    SRC_URI = "gitsmlocal://foo \<br>
                <a class="moz-txt-link-freetext">file://file1</a> \<br>
                <a class="moz-txt-link-freetext">file://file2</a> \<br>
                <a class="moz-txt-link-freetext">file://file3</a>"<br>
    a warning is issued for each of the local files: <br>
    /path/to/recipe/foo/foo_1.0.bb: Unable to get checksum for foo
    SRC_URI entry foo_file: file1 could not be found<br>
    /path/to/recipe/foo/foo_1.0.bb: Unable to get checksum for foo
    SRC_URI entry foo_file: file2 could not be found<br>
    /path/to/recipe/foo/foo_1.0.bb: Unable to get checksum for foo
    SRC_URI entry foo_file: file3 could not be found<br>
    <br>
    From debugging the code I figured, that bitbake seems to expect this
    file in the yocto-download cache, but it is not there. Instead, I
    found file1.done, file2.done and file3.done in the download cache.<br>
    <br>
    I am not sure if this is somehow related to the original problem,
    but I thought I should mention it here just in case.<br>
    <br>
    2) I tried to debug the bitbake run using the python debugger. I
    debugged on the krogroth branch, where described problem occured for
    the first time. I was analyzing the difference between the git
    fetcher and my custom fetcher. What I found was, that my fetcher was
    not properly initialized (urldata_init was not called) until the
    exception was thrown while the git fetcher was.<br>
    I tried to find out where the init call came from and found, that
    for the git fetcher the function "get_srcrev" was called, while for
    my custom fetcher it was not. This is where a Fetch object is
    initilalized which in turn calls the urldata_init function.<br>
    Maybe this helps to find the root cause of my problem?<br>
    <br>
    <br>
    Arno<br>
  </body>
</html>

--------------CBF03BC7784A21A3C61C5552--
