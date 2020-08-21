Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.42])
 by mx.groups.io with SMTP id smtpd.web11.126395.1597978590365225764
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 19:56:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=gxMQ+MIK;
 spf=pass (domain: windriver.com, ip: 40.107.77.42, mailfrom: hongxu.jia@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldqfgroOMe6LcDvxsRVzBrESWymhIXgnnmXV+pNnow2nsYxugWodnOzJt38GzvQljCPk8ntLAxv+uNqf/WQVHRoQViQ+NRCPdX+Y6YgVrqlcxyPNdWPp7EIFt57A6FRIzqR9BfKDHRMxNXfg32nJnDaMLN+3Ygr22Zv9lUKHlifldCFphjQ9MPjUfQQTX7G1YpfjW7w8XVmuKz2B4SxKdC/M/piby4xjQEQk4lV7gMl0AJBKLraRFvU7iwwdpZS+xUHvfG6Lj6G81JIxp5hSy2sPt2Snrprbon25hzmt5ctKWzRHnQCBEpOsXY9QkXD9yFBPkJ0XFabjQfAobfMazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl+6QgqIiN1SzyePpKvtWXU0ri9Vs/7RZ0B/TIjfgsU=;
 b=Qwgl6U+u4uPYKki/EiuzD9zpm620jOnAhZ68leAoGOmS2k8rIVyRAkVLPf60T4Oh4TSpRFbW2k1n2k99mOmrdd/dfVB3cIs2gDqCg1BNQisMhFYAwKNXP0bbbPtcFD7MitYFc+F3aj1E36GFUm7f+gtIXClIvKumFV1hduvZhvQXy15gUP3NLoPiAKvbTghFEYGutqUxfxHVSvN0UuT+xMlF37U6hg6XScyfyDmSTU/9ZPTm50/0Y1cmG1Z8wqpS97xUIVB1q7ecY66+OKv7wyMNqp1QHQxav4kBYp+KqDpvmP8/OKUilq802e2jUwmZfw/iWlOcT/B53Zt+oUg77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl+6QgqIiN1SzyePpKvtWXU0ri9Vs/7RZ0B/TIjfgsU=;
 b=gxMQ+MIKELK/7uagPQNCR+Frd127wCbT/UR+wkZMZFFZm8SsdCXgg7k8OcVkJdoQepsmC3Y/I6hRTpFglfF/ze2yi2CanwK+I2iB8WYw6VYYqfiB2xx9seUTZkrp5m3Z8P21Rm+S5CQ8GhmUTevNGO7y663NS69YL1LtpzvdmRg=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4380.namprd11.prod.outlook.com (2603:10b6:5:14e::20)
 by DM5PR11MB1465.namprd11.prod.outlook.com (2603:10b6:4:7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 21 Aug 2020 02:56:26 +0000
Received: from DM6PR11MB4380.namprd11.prod.outlook.com
 ([fe80::213c:2f71:aad:4494]) by DM6PR11MB4380.namprd11.prod.outlook.com
 ([fe80::213c:2f71:aad:4494%3]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 02:56:26 +0000
Subject: Re: [bitbake-devel] [PATCH] server/process: fix exit racing between process and thread
From: "hongxu" <hongxu.jia@windriver.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <162D282190DD8FB5.7353@lists.openembedded.org>
Message-ID: <9b28fe30-a475-2949-118e-1fe70aef4fe4@windriver.com>
Date: Fri, 21 Aug 2020 10:56:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <162D282190DD8FB5.7353@lists.openembedded.org>
X-ClientProxiedBy: BY5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::13) To DM6PR11MB4380.namprd11.prod.outlook.com
 (2603:10b6:5:14e::20)
Return-Path: hongxu.jia@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 02:56:25 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41be0645-636e-472d-c1e2-08d8457dcbc4
X-MS-TrafficTypeDiagnostic: DM5PR11MB1465:
X-Microsoft-Antispam-PRVS: 
	<DM5PR11MB14652ECC6238A11BFEF0656D945B0@DM5PR11MB1465.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G38a1+e4dnlHPSBCxqNEYLpfA2GhlTEopyQDYEOvOce+p+n1mNGutK70kbI3qQAuCAwYY4ifjYc45SiICu59d5Rkj0LzGPdaMojHZypNkP+YIa9mnuByIZfJfU6L7xa3R9zkxG2Oeoy1T8qTq1FjP8TfTUtNsXxpvc0gHSb6ONOUIkS6CF+vq1JEUxKjYkSo1StwAmYmCvg3Ebg6oAczwqHuezU4YQjjUlvVZ3LK9ozqMZRTUl2XmPoDVCwwK+ezxahW8KUfCtwEworXTNeu0OmsuxU8JYpxWKpRMj6aaJ9Z65kdbeAfEvXlKN2yyouFbVnKPztxbo5swTeYuZjXQQDpFH8RQxj/YfMc7/VnImR0+VKINlTjFLf1eGUce4yZSFJBp4k64tC3ccRiHrLcDfjHuG5zMaWM2Cvv8GYm2m44Xx9whuUz1sbaGpIpNB48SMrJMt9hvqSrAkSzIjj1uA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(52116002)(31686004)(44832011)(16576012)(316002)(6666004)(956004)(2616005)(31696002)(2906002)(478600001)(86362001)(966005)(66476007)(66556008)(66946007)(36756003)(6486002)(53546011)(110011004)(33964004)(186003)(26005)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	CFyLDXysAAbVamTHum9r3I20liqd/kEXDteEvyYMPVPeEHXRV1IUkDNywhGMYDGxoIpo0N0AqwDYhYcZr6R8GlGexOnHZ1/H3WX9AbC8m1dDEjCFPTxYSH/hssADE+XlZKUQoWLkFVtfjwK5JozUquiPPkG2QzTa981Ggj987EYfRLmGm6Oc/Q4EqscArnkNTKTL7mloxYkSAp7YL9wCQp/N5INv3RpKbdpaM3J2WDs0JFfUw9de1FMcXppJGwiJjpl3Y7vzH3KosPhp8W8WJH5W5H0n0rrsKhtq7UbcjjmqgtdPAiGWG0FI+iTDWhzJYYmkuAY08Nf4ahX5Ic5mh/ZVpoNH2RPzTJMNu4wmRqXNAZXLCc7Nag9mWGpJMR2G1NJzJKXxBd+6poPk1Fo39TJHGUURSpXjx39umFxxIuV5B1epp6zbRwuudChdOr4y2UW7sDRz+9PQPdSY8I59o97id+mSJvS826Sjc9HE/JjUlM35B/TfYUu9/jxH2pAqz6nSyOFord+TS2oBUfJd4g1uD+oqgsAbqsMHqBK04uFnJutW9+y0EcIhVnwtfiN/BdrLqDrIpN/BqLXQ+hKkEbwvkEw6WRh5MAkv+d+B3jn1FcdQ3f8ozmaT2ynOLb3eVNb+qnFbx0u4Z91Mx4o2ZA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41be0645-636e-472d-c1e2-08d8457dcbc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 02:56:26.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXY2dAKCO2h8/Fnxp4KJ858qeyHgHtRsYKz71WdcmjO8GD2gOgruYQOE6Jjfm2KuMS/Sn6b+i/2d0OMZM5lNNKRxiLq2D+CBu2Jj2/YNCIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1465
Content-Type: multipart/alternative;
 boundary="------------990908FE670D5A13B0A8D942"
Content-Language: en-US

--------------990908FE670D5A13B0A8D942
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi RP,

I have another solution to fix this issue, how about drop
thread invoking, directly call sync_caches in shutdown?
But there are some else multiprocessing.util.Finalize calling
in bitbake/lib/bb/cooker.py, I am not sure about the side effect

--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2130,10 +2130,7 @@ class CookerParser(object):
              for c in self.bb_caches.values():
                  c.sync()

-        sync = threading.Thread(target=sync_caches)
-        sync.start()
-        # While multiprocess exit, it should wait thread terminates
-        multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
+        sync_caches()
          bb.codeparser.parser_cache_savemerge()
          bb.fetch.fetcher_parse_done()
          if self.cooker.configuration.profile:

//Hongxu


On 8/21/20 10:39 AM, hongxu wrote:
> Since commit [d214e55c4 server/process: Remove pointless process
> forking][1] applied, there is an exit racing between process and
> thread which causing bb_cache.dat generation to be broken
>
> Here is a simple way to reproduce on poky
>
> 1) Edit poky
> [Edit poky]
> |--- a/bitbake/lib/bb/cooker.py
> |+++ b/bitbake/lib/bb/cooker.py
> |@@ -2126,11 +2126,13 @@ class CookerParser(object):
> |                 process.join()
> |
> |         def sync_caches():
> |+            time.sleep(2)
> |             for c in self.bb_caches.values():
> |                 c.sync()
> |
> |         sync = threading.Thread(target=sync_caches)
> |         sync.start()
> |+        # While multiprocess exit, it should wait thread to terminate
> |         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
> |         bb.codeparser.parser_cache_savemerge()
> |         bb.fetch.fetcher_parse_done()
> [Edit poky]
>
> 2) Run in build
> $ rm cache/ sstate-cache/  tmp/* -rf
> $ bitbake -p
> $ sleep 2
> $ ls tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* -sh
> |0 tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat
>
> Only a dying symlink, no real bb_cache.dat file was generated.
> When shutdown, it calls sync_caches in a thread to generate
> bb_cache.dat, and the thread is broken without finish
>
> Get multiprocessing.Process back, then above multiprocessing.util.Finalize
> will work, while process exit, it will wait the thread to terminate
>
> After applying the fix, bb_cache.dat is generated correctly:
> $ ls tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* -sh
> |  0 tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat
> |16M tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat.d2a12348d0bc9d63f396ffe81c752a4cfa21bc9ef64466305384767f375e052a
>
> [1] http://git.openembedded.org/bitbake/commit/?id=d214e55c45f9733b3289138feec0ae3361a4a48b
>
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>   lib/bb/server/process.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 65e1eab52..63b82458a 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -34,11 +34,12 @@ logger = logging.getLogger('BitBake')
>   class ProcessTimeout(SystemExit):
>       pass
>   
> -class ProcessServer():
> +class ProcessServer(multiprocessing.Process):
>       profile_filename = "profile.log"
>       profile_processed_filename = "profile.log.processed"
>   
>       def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
> +        multiprocessing.Process.__init__(self)
>           self.command_channel = False
>           self.command_channel_reply = False
>           self.quit = False
> @@ -487,7 +488,7 @@ class BitBakeServer(object):
>               print("Started bitbake server pid %d" % os.getpid())
>               sys.stdout.flush()
>   
> -            server.run()
> +            server.start()
>           finally:
>               # Flush any ,essages/errors to the logfile before exit
>               sys.stdout.flush()
>
> 



--------------990908FE670D5A13B0A8D942
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi RP,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">I have another solution to fix this
      issue, how about drop</div>
    <div class="moz-cite-prefix">thread invoking, directly call
      sync_caches in shutdown?</div>
    <div class="moz-cite-prefix">But there are some else
      multiprocessing.util.Finalize calling</div>
    <div class="moz-cite-prefix">in bitbake/lib/bb/cooker.py, I am not
      sure about the side effect<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">--- a/bitbake/lib/bb/cooker.py<br>
      +++ b/bitbake/lib/bb/cooker.py<br>
      @@ -2130,10 +2130,7 @@ class CookerParser(object):<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for c in self.bb_caches.values():<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c.sync()<br>
      &nbsp;<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sync = threading.Thread(target=sync_caches)<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sync.start()<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # While multiprocess exit, it should wait thread
      terminates<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multiprocessing.util.Finalize(None, sync.join,
      exitpriority=-100)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sync_caches()<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.codeparser.parser_cache_savemerge()<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.fetch.fetcher_parse_done()<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if self.cooker.configuration.profile:</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">//Hongxu<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 8/21/20 10:39 AM, hongxu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:162D282190DD8FB5.7353@lists.openembedded.org">
      <pre class="moz-quote-pre" wrap="">Since commit [d214e55c4 server/process: Remove pointless process
forking][1] applied, there is an exit racing between process and
thread which causing bb_cache.dat generation to be broken

Here is a simple way to reproduce on poky

1) Edit poky
[Edit poky]
|--- a/bitbake/lib/bb/cooker.py
|+++ b/bitbake/lib/bb/cooker.py
|@@ -2126,11 +2126,13 @@ class CookerParser(object):
|                 process.join()
|
|         def sync_caches():
|+            time.sleep(2)
|             for c in self.bb_caches.values():
|                 c.sync()
|
|         sync = threading.Thread(target=sync_caches)
|         sync.start()
|+        # While multiprocess exit, it should wait thread to terminate
|         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
|         bb.codeparser.parser_cache_savemerge()
|         bb.fetch.fetcher_parse_done()
[Edit poky]

2) Run in build
$ rm cache/ sstate-cache/  tmp/* -rf
$ bitbake -p
$ sleep 2
$ ls tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* -sh
|0 tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat

Only a dying symlink, no real bb_cache.dat file was generated.
When shutdown, it calls sync_caches in a thread to generate
bb_cache.dat, and the thread is broken without finish

Get multiprocessing.Process back, then above multiprocessing.util.Finalize
will work, while process exit, it will wait the thread to terminate

After applying the fix, bb_cache.dat is generated correctly:
$ ls tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* -sh
|  0 tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat
|16M tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat.d2a12348d0bc9d63f396ffe81c752a4cfa21bc9ef64466305384767f375e052a

[1] <a class="moz-txt-link-freetext" href="http://git.openembedded.org/bitbake/commit/?id=d214e55c45f9733b3289138feec0ae3361a4a48b">http://git.openembedded.org/bitbake/commit/?id=d214e55c45f9733b3289138feec0ae3361a4a48b</a>

Signed-off-by: Hongxu Jia <a class="moz-txt-link-rfc2396E" href="mailto:hongxu.jia@windriver.com">&lt;hongxu.jia@windriver.com&gt;</a>
---
 lib/bb/server/process.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 65e1eab52..63b82458a 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -34,11 +34,12 @@ logger = logging.getLogger('BitBake')
 class ProcessTimeout(SystemExit):
     pass
 
-class ProcessServer():
+class ProcessServer(multiprocessing.Process):
     profile_filename = &quot;profile.log&quot;
     profile_processed_filename = &quot;profile.log.processed&quot;
 
     def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
+        multiprocessing.Process.__init__(self)
         self.command_channel = False
         self.command_channel_reply = False
         self.quit = False
@@ -487,7 +488,7 @@ class BitBakeServer(object):
             print(&quot;Started bitbake server pid %d&quot; % os.getpid())
             sys.stdout.flush()
 
-            server.run()
+            server.start()
         finally:
             # Flush any ,essages/errors to the logfile before exit
             sys.stdout.flush()
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------990908FE670D5A13B0A8D942--
