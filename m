Return-Path: <mfumita@electromag.com.au>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9F1CFB424
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 02:52:30 +0000 (UTC)
Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
 by mx.groups.io with SMTP id smtpd.web10.44938.1728269539110200990
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Oct 2024 19:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: electromag.com.au, ip: 203.30.46.146, mailfrom: mfumita@electromag.com.au)
Received: (qmail 19843 invoked by uid 5089); 7 Oct 2024 02:52:16 -0000
Received: by simscan 1.2.0 ppid: 19516, pid: 19517, t: 1.6838s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
Received: from unknown (HELO ?192.168.2.146?) (mfumita@electromag.com.au@144.6.137.188)
  by anchovy3.45ru.net.au with ESMTPA; 7 Oct 2024 02:52:14 -0000
Content-Type: multipart/alternative;
 boundary="------------0WqX5PvWL7IulnItKtFDumeH"
Message-ID: <9aa944db-e60d-4b19-9865-afea669e8f5d@electromag.com.au>
Date: Mon, 7 Oct 2024 10:52:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] fetch2/svn: Support to feed an external
 SSL certificate file and its password
To: bitbake-devel@lists.openembedded.org
References: <20241004030640.10440-1-mfumita@electromag.com.au>
 <46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org>
Content-Language: en-AU
From: Morikazu Fumita <mfumita@electromag.com.au>
In-Reply-To: <46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Oct 2024 02:52:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16647

This is a multi-part message in MIME format.
--------------0WqX5PvWL7IulnItKtFDumeH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/2024 5:58 pm, Richard Purdie wrote:
> On Fri, 2024-10-04 at 11:06 +0800, Morikazu Fumita via lists.openembedded.org wrote:
>> Add parameters to feed an external SSL certificate and its password to the following SVN runtime options.
>>    --config-option=servers:global:ssl-client-cert-file="..."
>>    --config-option=servers:global:ssl-client-cert-password="..."
>>
>> Can be specified with:
>>    SRC_URI ="svn://[repository];protocol=https;cert_file=[certificate 
>> path];cert_pass=[password]"
>>
>> Signed-off-by: Mori Fumita<mfumita@electromag.com.au>
>> ---
>>   lib/bb/fetch2/svn.py | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
> These look like things which you really shouldn't be putting into a
> SRC_URI. Wouldn't they be better in the subversion config files within
> the user's HOME directory?
>
> We've not taken things adding support for passwords in various SRC_URIs
> since it encourages behaviour which isn't secure/recommended.
>
> Cheers,
>
> Richard
This patch isn't meant to hard-code the certificate path and password in 
the recipe files.
Instead, it allows for dynamic configuration.

Our SVN server requires an SSL certificate for access.
We install the certificate locally and configure SVN to use it.

We also have a build machine running Jenkins for CD/CI.
For security reasons, we don't want to install the certificate on this 
machine.

Instead, we've set up Jenkins to provide the certificate and password 
via environment variables
using "Credentials Binding" plugin.
Since Jenkins temporarily installs the certificate at a dynamically 
generated obfuscated path,
it isn't straightforward to configure it in the SVN configuration file 
in the home directory.
Additionally, we want to avoid storing the password on the build machine.

So, the "SRC_URI" in the recipe would look something like this, using 
"ENV_VAR_CERT" and "ENV_VAR_PASS",
which Jenkins supplies dynamically.
SRC_URI = 
"svn://[repository];protocol=https;cert_file=${ENV_VAR_CERT};cert_pass=${ENV_VAR_PASS}

Thanks,
Mori
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16638):https://lists.openembedded.org/g/bitbake-devel/message/16638
> Mute This Topic:https://lists.openembedded.org/mt/108811827/7022486
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [mfumita@electromag.com.au]
> -=-=-=-=-=-=-=-=-=-=-=-
>

--------------0WqX5PvWL7IulnItKtFDumeH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 4/10/2024 5:58 pm, Richard Purdie
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">On Fri, 2024-10-04 at 11:06 +0800, Morikazu Fumita via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add parameters to feed an external SSL certificate and its password to the following SVN runtime options.
  --config-option=servers:global:ssl-client-cert-file="..."
  --config-option=servers:global:ssl-client-cert-password="..."

Can be specified with:
  SRC_URI = <a class="moz-txt-link-rfc2396E" href="svn://[repository];protocol=https;cert_file=[certificatepath];cert_pass=[password]">"svn://[repository];protocol=https;cert_file=[certificate path];cert_pass=[password]"</a>

Signed-off-by: Mori Fumita <a class="moz-txt-link-rfc2396E" href="mailto:mfumita@electromag.com.au">&lt;mfumita@electromag.com.au&gt;</a>
---
 lib/bb/fetch2/svn.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
These look like things which you really shouldn't be putting into a
SRC_URI. Wouldn't they be better in the subversion config files within
the user's HOME directory?

We've not taken things adding support for passwords in various SRC_URIs
since it encourages behaviour which isn't secure/recommended.

Cheers,

Richard</pre>
    </blockquote>
    This patch isn't meant to hard-code the certificate path and
    password in the recipe files.<br>
    Instead, it allows for dynamic configuration.<br>
    <br>
    Our SVN server requires an SSL certificate for access.<br>
    We install the certificate locally and configure SVN to use it.<br>
    <br>
    We also have a build machine running Jenkins for CD/CI.<br>
    For security reasons, we don't want to install the certificate on
    this machine.<br>
    <br>
    Instead, we've set up Jenkins to provide the certificate and
    password via environment variables<br>
    using "Credentials Binding" plugin.<br>
    Since Jenkins temporarily installs the certificate at a dynamically
    generated obfuscated path,<br>
    it isn't straightforward to configure it in the SVN configuration
    file in the home directory.<br>
    Additionally, we want to avoid storing the password on the build
    machine.<br>
    <br>
    So, the "SRC_URI" in the recipe would look something like this,
    using "ENV_VAR_CERT" and "ENV_VAR_PASS",<br>
    which Jenkins supplies dynamically.<br>
    SRC_URI =
"<a class="moz-txt-link-freetext" href="svn://[repository];protocol=https;cert_file=$">svn://[repository];protocol=https;cert_file=$</a>{ENV_VAR_CERT};cert_pass=${ENV_VAR_PASS}<br>
    <br>
    Thanks,<br>
    Mori<br>
    <blockquote type="cite"
cite="mid:46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#16638): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/16638">https://lists.openembedded.org/g/bitbake-devel/message/16638</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/108811827/7022486">https://lists.openembedded.org/mt/108811827/7022486</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:mfumita@electromag.com.au">mfumita@electromag.com.au</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <br>
  </body>
  <lt-container></lt-container>
</html>

--------------0WqX5PvWL7IulnItKtFDumeH--

