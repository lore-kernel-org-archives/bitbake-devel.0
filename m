Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54])
	by mail.openembedded.org (Postfix) with ESMTP id 78D4B61B62
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:13 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id d15so9773350iog.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hr9dryjHTlhNSJ9Ns5uD940C1U8021JNCYHN/HwNR1s=;
	b=qQutinFAb3qk9paqVGFLi6p+Y5pYaJ2Z5SeZPEHokO7DuHd9bC/URKvDhRY8sF/lkP
	xbiCqhswblVyQiRaV8raBNGmurhE27Lm2V69fA6asWyaP2sgMwHVLTRHzgpbRkdG8+LI
	Q59AujP1DjOoTuZSOe4jL+4MQMVT/bdx+LdB1yW9sTT6xqzoe+3rY9rKrrJIzHHgKfqg
	LLu0+MBj0lM5vGdY8a0SQix34WMbu4QxEoQEoRytp1SsJksJE8oAr4EckOE5t2LQ0an6
	5ex29vNLdhxDTu4DxS5xZs4/GoROus7V/zJhHuJ0nwy1TAoZt4ze4zxpaMQaki+XDKC0
	gNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hr9dryjHTlhNSJ9Ns5uD940C1U8021JNCYHN/HwNR1s=;
	b=R4fUczVf8e9lbT0aQCmDpdY3PgGrjHXUNy58xaPRHUCIiw4HJNVQSv+3Jczld+kryx
	juVBXge/VT9949C3lcuZjHs8LboB6bAnOEljzFxGM0TuihBrrTlTZBuidM8TDdPC4/QR
	uzSydTb8v+FDxjIJnwWzt8mRJGrurAMEUv1EcgafMFFpkg+s9CrpP9loOk8rJ8hvGn+G
	1HycS/qtc4Mie8ox7UyPK7vL6G2lJZ3aiWk8AJhlqqrOWxLWhQJiVUHt07OvM3Gj/SUX
	ZatGVmf7wwrMJw70rwI4sPpmMQ6Ad4d1ZqFWl9shnBNIHYHt3Bztn0s2r84ZVx1LrDW8
	rGzw==
X-Gm-Message-State: ANhLgQ2DvfzREdROCjFYu/SFn2xL45q0GOFjKYmoBp/ctq45i5F4MAON
	xQYz71KG3rbfWZ7WHvMvSNNzenu23Rw=
X-Google-Smtp-Source: ADFU+vtAShaCwGCu2lIM7yfk1qAp5Lgl2VJZ7NdpgtsooDJDrd+7TaZa5U+tdnOUA5dOQfGZt/aI+A==
X-Received: by 2002:a02:a610:: with SMTP id c16mr15754992jam.43.1583771654264; 
	Mon, 09 Mar 2020 09:34:14 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.13
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:13 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:53 -0500
Message-Id: <20200309163353.15362-16-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 15/15] bitbake-user-manual: Add documentation for BB_LOGCONFIG
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:15 -0000

Adds documentation describing how to use the BB_LOGCONFIG variable to
enable custom logging.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../bitbake-user-manual-execution.xml         | 97 +++++++++++++++++++
 .../bitbake-user-manual-ref-variables.xml     | 11 +++
 2 files changed, 108 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 8f606676b4..3b31f748cc 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -929,4 +929,101 @@
             section.
         </para>
     </section>
+
+    <section id="logging">
+        <title>Logging</title>
+        <para>
+            In addition to the standard command line option to control how
+            verbose builds are when execute, bitbake also supports user defined
+            configuration of the
+            <ulink url='https://docs.python.org/3/library/logging.html'>Python logging</ulink>
+            facilities through the
+            <link linkend="var-bb-BB_LOGCONFIG"><filename>BB_LOGCONFIG</filename></link>
+            variable. This variable defines a json or yaml
+            <ulink url='https://docs.python.org/3/library/logging.config.html'>logging configuration</ulink>
+            that will be intelligently merged into the default configuration.
+            The logging configuration is merged using the following rules:
+            <itemizedlist>
+                <listitem><para>
+                    The user defined configuration will completely replace the default
+                    configuration if top level key
+                    <filename>bitbake_merge</filename> is set to the value
+                    <filename>False</filename>. In this case, all other rules
+                    are ignored.
+                </para></listitem>
+                <listitem><para>
+                    The user configuration must have a top level
+                    <filename>version</filename> which must match the value of
+                    the default configuration.
+                </para></listitem>
+                <listitem><para>
+                    Any keys defined in the <filename>handlers</filename>,
+                    <filename>formatters</filename>, or <filename>filters</filename>,
+                    will be merged into the same section in the default
+                    configuration, with the user specified keys taking
+                    replacing a default one if there is a conflict. In
+                    practice, this means that if both the default configuration
+                    and user configuration specify a handler named
+                    <filename>myhandler</filename>, the user defined one will
+                    replace the default. To prevent the user from inadvertently
+                    replacing a default handler, formatter, or filter, all of
+                    the default ones are named with a prefix of
+                    "<filename>BitBake.</filename>"
+                </para></listitem>
+                <listitem><para>
+                    If a logger is defined by the user with the key
+                    <filename>bitbake_merge</filename> set to
+                    <filename>False</filename>, that logger will be completely
+                    replaced by user configuration. In this case, no other
+                    rules will apply to that logger.
+                </listitem></para>
+                <listitem><para>
+                    All user defined <filename>filter</filename> and
+                    <filename>handlers</filename> properties for a given logger
+                    will be merged with corresponding properties from the
+                    default logger. For example, if the user configuration adds
+                    a filter called <filename>myFilter</filename> to the
+                    <filename>BitBake.SigGen</filename>, and the default
+                    configuration adds a filter called
+                    <filename>BitBake.defaultFilter</filename>, both filters
+                    will be applied to the logger
+                </listitem></para>
+            </itemizedlist>
+        </para>
+
+        <para>
+            As an example, consider the following user logging configuration
+            file which logs all Hash Equivalence related messages of VERBOSE or
+            higher to a file called <filename>hashequiv.log</filename>
+            <literallayout class='monospaced'>
+    {
+        "version": 1,
+        "handlers": {
+            "autobuilderlog": {
+                "class": "logging.FileHandler",
+                "formatter": "logfileFormatter",
+                "level": "DEBUG",
+                "filename": "hashequiv.log",
+                "mode": "w"
+            }
+        },
+        "formatters": {
+                "logfileFormatter": {
+                    "format": "%(name)s: %(levelname)s: %(message)s"
+                }
+        },
+        "loggers": {
+            "BitBake.SigGen.HashEquiv": {
+                "level": "VERBOSE",
+                "handlers": ["autobuilderlog"]
+            },
+            "BitBake.RunQueue.HashEquiv": {
+                "level": "VERBOSE",
+                "handlers": ["autobuilderlog"]
+            }
+        }
+    }
+            </literallayout>
+        </para>
+    </section>
 </chapter>
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index bae01d90c0..c4bd1f2584 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -539,6 +539,17 @@
             </glossdef>
         </glossentry>
 
+        <glossentry id='var-bb-BB_LOGCONFIG'><glossterm>BB_LOGCONFIG</glossterm>
+            <glossdef>
+                <para>
+                    Specifies the name of a config file that contains the user
+                    logging configuration. See
+                    <link linkend="logging">Logging</link> for additional
+                    information
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-bb-BB_LOGFMT'><glossterm>BB_LOGFMT</glossterm>
             <glossdef>
                 <para>
-- 
2.17.1


