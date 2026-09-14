Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8ABC88E65
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 11:01:14 +0000 (UTC)
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17718.1789383664290278839
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 04:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=SNnZ9E1R;
 spf=pass (domain: cisco.com, ip: 173.37.86.79, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=14073; q=dns/txt;
  s=iport01; t=1789383664; x=1790593264;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=15/qNEx/pYhmCXkaYzBXI0Ln2U/ug9iehx03AYdjg9M=;
  b=SNnZ9E1RjSB1e9bTbq6z0nyAbBLpJqv1mi86OQswTZTEdjX8IUSNKb0w
   3NSOuwkjcSMswIR3tWUQOu6UYT1w47ve0UImiDOB2LGRQlEo720ePtHjl
   T7rn416mySFn62pp5ZN0X7SMTdhuuE0nqtdBc6y7NCpa9SgPT9VJ4Vq3b
   7Ld4hGZ4I66+ELJAHYzQI+6lFvrA1bB1v0Nrt/5csSOZ3mAuQS7GyLneI
   TBgZ+yblyWPTxgrUb9m312tAul4ZGfqpxtgsl0/i6jMaFmmV+M+aVmaFf
   oJNuwIVfFLAlNE8iKnEGu3iYWuncxAhfqvv191MVT0zFhwxEwzYMjLtCr
   Q==;
X-CSE-ConnectionGUID: XcmzGl2gTLiPJ+NAPL8fkA==
X-CSE-MsgGUID: lXC5b1kOTVa8vZcY3NC8Jw==
X-IPAS-Result: =?us-ascii?q?A0ApAAB006dq/4//Ja1aHAEBAQEBAQcBARIBAQQEAQFlg?=
 =?us-ascii?q?RgGAQELAYFtUxZzAoEjSYgjA4UrhliCIYEWnQiBfg8BAQENAjEgBAEBhQUCj?=
 =?us-ascii?q?gUCJjUIDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECAQcFgQ4Thk8NkSQBf?=
 =?us-ascii?q?ycEARIIgnuCdAMBArk4AolLGzd4gTSBAeAwAQsUAYE4AYhdAYV4O4RBJxuCD?=
 =?us-ascii?q?YEVQoIxdoRFhBOCMASCIoEMgVqBDHEZfoVVA4lLgUocA1ksAVUTFwsHBYFmA?=
 =?us-ascii?q?yovLTI8Mh2BIxIsFy9YGwYFgR2BJ4JiIxk2eoEJXoErKWESF4EJgggCglSCA?=
 =?us-ascii?q?QIBSUMOB0VTCSdBAwcSTCkiCBIGC209NxUZAwSBNQWPBh+CEEYHAXMQCgErF?=
 =?us-ascii?q?zlBBwhMEUIPGBSSaQiQFoE1jGSVFwqEHowilXAXhASBV6USmQgjgjahE4UsA?=
 =?us-ascii?q?gQCBAUCEAEBBoFqATmBWXAVO4JnCUoZD44vFYlExjV5PQIHAgcOAwuTZgEB?=
IronPort-PHdr: A9a23:Wzto7h+JfZT6kP9uWBDoyV9kXcBvk6//MghQ7YIolPcUNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:U4EWX61ke42SoPaosPbD5Yxwkn2cJEfYwER7XKvMYLTBsI5bp2AGy
 GseX2yEPK6JMWCjL4tyO46+pE8O75fUmN8xTFdt3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7g28tbjpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGPEozL6IcoOlLJWB21
 78+AQgpPh6ArrfjqF67YrEEasULNsLnOsYb/3pn1zycVahgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUibC/FMEg9/5JYWh/mzmHT5aCZwo1OOrq1x6G/WpOB0+OW0bYeOIIzQGa25mG6cl
 kmb9T36JS0kPYyB+zG0qVSH1s3QyHaTtIU6UefQGuRRqFeS2mYaCxBTWValrP2Rjk+lR8kZL
 FQZ/Ccrp6U++EGnCN7nUHWFTGWspBUQXZ9UVuY98gzIkvSS6AeCDW9CRTlEADA7iPILqfUR/
 gbht/viBCdkt/ueTnf1y1tehWja1fQ9RYPaWRI5cA==
IronPort-HdrOrdr: A9a23:30NqwalWsZgUSwuKPrCEFLZckQzpDfM/iWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj8fZq9z/JICPoqTMuftW7dySaVxeBZnMHfKlLbalbDH4JmpM
 NdmstFeZHN5DpB/LzHCWCDer5KrqjkgcWVbIzlvhFQpHRRGtldBnBCe3+m+yNNNW57LKt8Pq
 CxouBAoD2tc2kWaMOUOlkpNtKom/T70LjdTVojHRAI1Cmi5AnE1JfKVzSI1BYXVD1ChYwl7X
 XElALB4KCiueGQyxPX1WPfhq4m1+cJzOEtOOW8zuwubhn8gAehY4psH5eYuioune2p4FE21P
 HRvhYJJa1ImjLsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhLhebgDS5yMbzZFBOe
 NwriGkXqhsfFb9dRfGlpz1vtZR5w2JSE8Z4KwuZrpkIM0jgfFq3NUiFQhuYeg99WrBmf4a+a
 9VfY/hzccTV0+GZHbEuWQq6tmtUnMvWiqieCE5y5SoO/w8pgEi86Per/ZvxUvp+P8GOuh5zv
 WBPaJymL5USMgKKap7GecaWMOyTnfAWBTWLQupUB3a/Yw8SgXwQqTMkcMIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnL2JFQ6BjCTGi0QDyok6hlltNEk6y5QKCuPTyISVgoncflq/IDAtfDU/
 L2PJ5NGffsIWbnBI4M1QzjXJtZL2UYTaQuy54GckPLptiOJpzht+TdfvqWLL3xESw8Ume6GX
 cHVCibHrQ10qlqYA6MvPH8YQKeRqWkx+MBLEHzxZlh9LQw
X-Talos-CUID: 9a23:2NpAFG7aLLTDVvqtxtssxEURCO8hKHLh6HboAQyeIF5NGLOWYArF
X-Talos-MUID: =?us-ascii?q?9a23=3Ap6oK9g779IMN4aOEw2MNZNhaxoxs04/zAhkOtqk?=
 =?us-ascii?q?4spmaBydBYBG23BaoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Sep 2026 11:00:47 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 56AAD1800048C
	for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 11:00:47 +0000 (GMT)
X-CSE-ConnectionGUID: JNgDpe21TBiaNt7dLxV/GQ==
X-CSE-MsgGUID: ubjoz9p1T7WMzozJfDU1TA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.27,102,1787011200"; 
   d="scan'208";a="73699261"
Received: from mail-centralusazon11011054.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.54])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Sep 2026 11:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi0whcnCg/5f1kuIglL/5ETWMWsWZaDRQHCFpRpoVddQnBOP3uTKBxAXVp7hz7dRjrMGv/TEypXKIVz7mG+WfPYWOOSc2NVdakNoGbFBdsH+qjayXe8bkY4baT1DrmYtZvptbnFUsJicgfmU4LqsO/ATjJCkf9YiBjsrmh7enICxiIYk3nnjb6/6gZkYNBYFaU7Wbw9qenVGMmdafq2V5pjQauLow1oipg+gHsbYEk6KiUrdGdKqTJGg+dCbIwj+7nSnDNRxhknBSFsJsT3yAsnWHk1It+wrTv9rI09W46A5O4emjsOyJfxAlhBHwrG1tXoZlZTXxNDjFoaSS7Fihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15/qNEx/pYhmCXkaYzBXI0Ln2U/ug9iehx03AYdjg9M=;
 b=IqndABryLuNZhTZayyL6ly083ZRS/+4h2bHKKxafmLFWfr5lfiT/CGrHKzKuP8SKUMacRItabO78GWHp6rWq+WAAXZ5jv9R5e4/OCb+kXAdoxGzzw7fnp4MU5nsqRdhTHVkNkycvto4qig2ZJpPUKi6Ridt4zn4tnD5+Yp2utV9pTV77W2DlRJpaXQeuPso5RznzqH69Za5Mnv/Qz7el9DYrHgoGO+agUqVhybHQYexr0TeoT1LT44CWy7oAO8EdKCy4YTvuZZ5J7sG8c4kQ1Y8ke+FcYkG5EqQnguANwP5kWdfBGjS2ZRs3p7RA82tNG0lBhhQaweV+z9eGd20tzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 11:00:44 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:00:44 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3] fetch/git: unpack from premirror when cached clone is
 stale
Thread-Topic: [PATCH v3] fetch/git: unpack from premirror when cached clone is
 stale
Thread-Index: AQHdRDXrwr9uhxYuSEeZA19OEZk54Q==
Date: Mon, 14 Sep 2026 11:00:44 +0000
Message-ID: 
 <DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|PH3PPF9E162731D:EE_
x-ms-office365-filtering-correlation-id: e8f13483-5ce6-414f-890f-08df124f6c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|5023799004|11063799006|56012099006|10067099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 
 Kdc2V0DyfEbgiySxMFbfwugHbAktUIV1vy0iabi3fuE7CWqsZkFfIcxVNkt9/jNx5RQXVuieNpDlrmsknwVNGaTLbOd4aQcGJa8Zz2yHZ+H5+PCJrmpkWAI9Nrt4GOgZzmDNptZpW363evB7f5bspZa6xKPNVKqUK2koKYmxacFCtbiY0Zm49+TLmss8ae44i+Kpm/poCbGayRup+fjrKFp+4FVT7YZj6VT9g+wLcuayXXBt447M2e5vCdXtJHJ2n687NHns72tYL9jagYK9CUAyVkVqWj43WzL3MwBRNbdcnUx5S3aOKfvHT/fa3G8rYCbhMRbbcSjW25B/0L/vlzPIyNGcxFzAWpIU+GuMdH6r42LjpUKhH4kEFL+4losoNEuW4BwZ+OVp4dDN5hAEHOcXxozteAXoZ7W1DLCQV1e6QQWBUnBuYUvrzPyUPpUwvhdkGRdmWo/2qgH7EllzAc4/rUSBS6u+iRBJ9QOz/g2Ymw98jk4GUUSV/ySe1F5CU/RFLD4FrNbyIVdaOHLnWlpie2VT7/HqyPbT2i2vAFh2Yn/WIJwNhimBKplmMZb/xDOjjTeLAljZ0CDv5PvaOKIXlGqyazNddEun2e1b+RZeACz0Pry985siuFUD45lkxfh6L8ZyC3LnJnna6GLpcO1ghiNIGrcPrQpOFIZ7U9h3lL0a5Vn9uvxfJJO/L4D5XK5ummQNmt6ofc51h2Z5CauL4hcsRcmC2lrkWCDE6CY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?X3jfX/HJajmuUzwf24GsHXSBSWtQRGXl8Qs+jZuEtotFPWx+9QD8rJKHrY?=
 =?iso-8859-1?Q?xu/57S8E6zKDQpVtSqkm7FR2iy2OcNEzv1ahhUdJgy3rgdeMwNrlVcHT4n?=
 =?iso-8859-1?Q?W1nU7Dh6zdPgwpHrZFIwFvMqif6iVHt0vhVkpJAdHbK5Bt82Nm8InMgJZv?=
 =?iso-8859-1?Q?WTHbcgQWyPze22guZBHzQVc35HFfKG1g2vX+k1pgDtkeaT5NLg2XZ0FpsH?=
 =?iso-8859-1?Q?eq/rc3/d7pivgm4q+sDmrwTLiIsKSuFsW1E77qGJxiRnmTEHnxgLEJk3xC?=
 =?iso-8859-1?Q?H32dWmPndck1wE3cL00MTX5MvT5TlUHOuMqirVUJnWH4//xE5NwpHVfsGu?=
 =?iso-8859-1?Q?goQa+tu/vXJ5HD3M8z9BGRGXa+RLUmRsvMgMU9qK5ATtTNPu80FKVDV4zl?=
 =?iso-8859-1?Q?2Uno8k+p/ILCUVOPVBBhcNXk5ccQe+U6GFIseCj3tUe4ysyeNjrNNzhK7h?=
 =?iso-8859-1?Q?V8ud72omYTS5KaPXoQWI1D5WHW1/e4scrfQfKsGnrL3qxoFqb/nvwdx32O?=
 =?iso-8859-1?Q?ShnJ5zacnrS7ywswiOy0jEb2f6LNsoI0Oq6K6iHQbrSt+0TndDaUfBfJjm?=
 =?iso-8859-1?Q?QcAGfxApEpqoYuV6SlzjMeFpMSsKoS1syuSeW0aLuHkWalklWMETPLM4U7?=
 =?iso-8859-1?Q?xsVWDR1zVJ6faIry4HEkKc2kU/1Q5M3ARsSpBYejiZ9ql/NsUhkDFrJHQY?=
 =?iso-8859-1?Q?DcJRoe0dNWjEja//yPFyvunrHpIVk97IqLKRMerOvseuSygJW4zXD/Nl5+?=
 =?iso-8859-1?Q?htyOWlvNUmCLsu4jqXk0q8C8klo3i58BlPlCw0Nkrd4UV3TvcxhrDIWFN3?=
 =?iso-8859-1?Q?10Ppuk3xzVIszPbY1e4QGQ2W4gUd7z1fZDM66oDR5P6rnfZdJXGJgpJ8ys?=
 =?iso-8859-1?Q?iaplTBGWEJWNAairMUiQOKVmMXoLzh6K7ZCHkc+DA3RoBh5VErjsvfCj0f?=
 =?iso-8859-1?Q?eMQXIYAmeNMBsVQuxblvW997Ctat8F1XzToeuojA9Ig/x1pHMCFLJRlc5d?=
 =?iso-8859-1?Q?XoAJrhz1KmGiuDoKF0fJjd7YrIdFF7EaiZQDbTK54j3AoLBBkQMG5QiToK?=
 =?iso-8859-1?Q?P+yXApgKQdeOvb1zw4VuU2N+epNznmitXh6we27mAT4wa8pYXny7OpEFUu?=
 =?iso-8859-1?Q?5xfYyHo03z24RBo2T58NOUEkqHUEzN8kzhzPnVNHppfV/2kJ2UZRZU5kpd?=
 =?iso-8859-1?Q?nMiAYFHUfln+jC65fQZnYqNSuo6/x7xfWnAXfxoRC/71Q/LN/vehNVO690?=
 =?iso-8859-1?Q?Qq4V2DKyZKnlceKgdm5jndxBDXMw6BRl6Odcubz+nxnqPU46o/KbVu3ft7?=
 =?iso-8859-1?Q?+hQCAu21W3CoNReui2LBp+W9iCmm49QxQvtpQ+TDoTqdANdh15a09GFsD+?=
 =?iso-8859-1?Q?EdEUtMDv2jT6MEfUo8J94ABN1F5bIptwTx/DDXPul1NG/DiP3RcRpYpaDW?=
 =?iso-8859-1?Q?IzfCDxQD0TsotrHtKBAJfJRpzMBB1F04tueMWMMU1ZfQYZsKchHcQDEQ2o?=
 =?iso-8859-1?Q?zdI8O76rBQlOkK94stNG8SNuuMSb/pCxCy1KoltxQlbL8z6vMD40SnNuza?=
 =?iso-8859-1?Q?8CMMl21DEaMzshabYWa4j8Bs52cpFYwLJyPzIvt6PJiIsflenNsJggRWwe?=
 =?iso-8859-1?Q?3naZcPz+nBhB8tKpZQUot7SoIqRS2y7nVIIJUtSJrq+6yptQ+P2bmu0iT3?=
 =?iso-8859-1?Q?Uw2DORqzfXslDDoblebn5GH0f1s5ybfvZsWYtbpGabQvKWJ+zq+eu3fIRt?=
 =?iso-8859-1?Q?/EREKFlZKwcWX2TTLWUJ8Tmo8ZBXv1xO3ZfPxFVCgMe57I?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	5mLuFxpqV7rPsn73PaorIy0lzvOb8jqFyVy3O1aVa1xE/CykR29U3Huqpt5F4bpVvM3MV6QSeShuZCFX9P4K8tJ3OQJ99r5hIx2/uicLg/uaW7NfwZCmt1/VvMW/p5viRTPyvftTbVG0xm6jHzpl/vWceUe4Mft7TFiR1NFCA56oMtl0PH+qnyFMwy9jFjeAP/WMlXJ960lY+7QSR+vA/GADailE1onqnWyPCge3Kd4nXQ3ot1FsDVBImn/betc8Z4gh49u+Xd3ltwV+GrlIWMXhHayoU97MVeTvZqdpGAxAcZ9tTXlcl7HZ6Ob1Eh3pDD5dhAAMg0BQPcYTaVKSdQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f13483-5ce6-414f-890f-08df124f6c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 11:00:44.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dL1p2lFxlgppK0OgAHmhrhHCKHw87E4VcdjJngxA4gR+qXxEvSDhwV475pVgXPpYonpRNaHtAOPnR2fo6n7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-2.cisco.com [72.163.7.163];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 11:01:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20195

The failure happens as follows:=0A=
=0A=
1. BitBake has an old Git clone for the original URL.=0A=
2. That clone does not contain the commit being built.=0A=
3. BitBake successfully fetches the commit from a premirror into another cl=
one.=0A=
4. BitBake tries to unpack from the old clone and fails.=0A=
=0A=
Remember the clone used by the successful premirror fetch and unpack from i=
t.=0A=
Leave both clones unchanged and preserve the premirror clone during clean.=
=0A=
=0A=
Add a test for this case.=0A=
=0A=
Signed-off-by: Fredrik Svensson <fredriks@meraki.com>=0A=
---=0A=
Thanks for the feedback.=0A=
=0A=
This version leaves the stale clone untouched. It remembers the clone used =
by=0A=
the successful premirror fetch and uses that clone for unpacking.=0A=
=0A=
It also removes update_mirror_links. A symlink is still created when the=0A=
original clone path is absent, but clean no longer follows that symlink, so=
 it=0A=
does not remove the premirror clone.=0A=
=0A=
The updated self-test verifies that unpack uses the premirror revision, the=
 old=0A=
clone is unchanged, and clean preserves the premirror clone.=0A=
=0A=
Changes in v3:=0A=
- do not delete or replace the stale clone;=0A=
- use origud to remember the successful premirror path;=0A=
- remove update_mirror_links;=0A=
- preserve the premirror clone during clean; and=0A=
- update the self-test for the new behavior.=0A=
=0A=
lib/bb/fetch/__init__.py | 48 +++++++++++++-------------------=0A=
 lib/bb/fetch/git.py      | 60 +++++++++++++++++++---------------------=0A=
 lib/bb/tests/fetch.py    | 49 ++++++++++++++++++++++++++++++++=0A=
 3 files changed, 97 insertions(+), 60 deletions(-)=0A=
=0A=
diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py=0A=
index 55ab710f..4d5e7b0d 100644=0A=
--- a/lib/bb/fetch/__init__.py=0A=
+++ b/lib/bb/fetch/__init__.py=0A=
@@ -587,6 +587,11 @@ def mirror_from_string(data):=0A=
         bb.warn('Invalid mirror data %s, should have paired members.' % da=
ta)=0A=
     return list(zip(*[iter(mirrors)]*2))=0A=
 =0A=
+def downloaded_path(ud):=0A=
+    """Return the path obtained for a URL, including from a mirror."""=0A=
+    return getattr(ud, "mirrorpath", ud.localpath)=0A=
+=0A=
+=0A=
 def verify_checksum(ud, d, precomputed=3D{}, localpath=3DNone, fatal_noche=
cksum=3DTrue):=0A=
     """=0A=
     verify the MD5 and SHA256 checksum for downloaded src=0A=
@@ -1147,11 +1152,18 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):=0A=
                 if hasattr(origud.method, "build_mirror_data"):=0A=
                     origud.method.build_mirror_data(origud, ld)=0A=
             return origud.localpath=0A=
-        # Otherwise the result is a local file:// and we symlink to it=0A=
-        # This may also be a link to a shallow archive=0A=
-        # When using shallow mode, add a symlink to the original fullshall=
ow=0A=
-        # path to ensure a valid symlink even in the `PREMIRRORS` case=0A=
-        origud.method.update_mirror_links(ud, origud)=0A=
+        # Use origud to find the URL which started a mirror chain and reco=
rd=0A=
+        # the successful result without changing an existing download.=0A=
+        mirrororigud =3D ud.origud=0A=
+        while hasattr(mirrororigud, "origud"):=0A=
+            mirrororigud =3D mirrororigud.origud=0A=
+        mirrororigud.mirrorpath =3D ud.localpath=0A=
+        if not os.path.lexists(mirrororigud.localpath):=0A=
+            bb.utils.mkdirhier(os.path.dirname(mirrororigud.localpath))=0A=
+            try:=0A=
+                os.symlink(ud.localpath, mirrororigud.localpath)=0A=
+            except FileExistsError:=0A=
+                pass=0A=
         update_stamp(origud, ld)=0A=
         return ud.localpath=0A=
 =0A=
@@ -1676,28 +1688,6 @@ class FetchMethod(object):=0A=
         """=0A=
         bb.utils.remove(urldata.localpath)=0A=
 =0A=
-    def ensure_symlink(self, target, link_name):=0A=
-        if not os.path.exists(link_name):=0A=
-            dirname =3D os.path.dirname(link_name)=0A=
-            bb.utils.mkdirhier(dirname)=0A=
-            if os.path.islink(link_name):=0A=
-                # Broken symbolic link=0A=
-                os.unlink(link_name)=0A=
-=0A=
-            # In case this is executing without any file locks held (as is=
=0A=
-            # the case for file:// URLs), two tasks may end up here at the=
=0A=
-            # same time, in which case we do not want the second task to=
=0A=
-            # fail when the link has already been created by the first tas=
k.=0A=
-            try:=0A=
-                os.symlink(target, link_name)=0A=
-            except FileExistsError:=0A=
-                pass=0A=
-=0A=
-    def update_mirror_links(self, ud, origud):=0A=
-        # For local file:// results, create a symlink to them=0A=
-        # This may also be a link to a shallow archive=0A=
-        self.ensure_symlink(ud.localpath, origud.localpath)=0A=
-=0A=
     def try_premirror(self, urldata, d):=0A=
         """=0A=
         Should premirrors be used?=0A=
@@ -1869,7 +1859,7 @@ class Fetch(object):=0A=
             self.ud[url] =3D FetchData(url, self.d)=0A=
 =0A=
         self.ud[url].setup_localpath(self.d)=0A=
-        return self.ud[url].localpath=0A=
+        return downloaded_path(self.ud[url])=0A=
 =0A=
     def localpaths(self):=0A=
         """=0A=
@@ -1880,7 +1870,7 @@ class Fetch(object):=0A=
         for u in self.urls:=0A=
             ud =3D self.ud[u]=0A=
             ud.setup_localpath(self.d)=0A=
-            local.append(ud.localpath)=0A=
+            local.append(downloaded_path(ud))=0A=
 =0A=
         return local=0A=
 =0A=
diff --git a/lib/bb/fetch/git.py b/lib/bb/fetch/git.py=0A=
index dc1b31b5..836def49 100644=0A=
--- a/lib/bb/fetch/git.py=0A=
+++ b/lib/bb/fetch/git.py=0A=
@@ -77,6 +77,7 @@ import bb=0A=
 import bb.progress=0A=
 from contextlib import contextmanager=0A=
 from   bb.fetch import FetchMethod=0A=
+from   bb.fetch import downloaded_path=0A=
 from   bb.fetch import runfetchcmd=0A=
 from   bb.fetch import logger=0A=
 from   bb.fetch import trusted_network=0A=
@@ -317,14 +318,15 @@ class Git(FetchMethod):=0A=
                 or self.tarball_need_update(ud) \=0A=
                 or self.lfs_need_update(ud, d)=0A=
 =0A=
-    def clonedir_need_update(self, ud, d):=0A=
-        if not os.path.exists(ud.clonedir):=0A=
+    def clonedir_need_update(self, ud, d, clonedir=3DNone):=0A=
+        clonedir =3D clonedir or ud.clonedir=0A=
+        if not os.path.exists(clonedir):=0A=
             return True=0A=
-        if ud.shallow and ud.write_shallow_tarballs and self.clonedir_need=
_shallow_revs(ud, d):=0A=
+        if ud.shallow and ud.write_shallow_tarballs and self.clonedir_need=
_shallow_revs(ud, d, clonedir):=0A=
             return True=0A=
-        if not self._contains_ref(ud, d, ud.name, ud.clonedir):=0A=
+        if not self._contains_ref(ud, d, ud.name, clonedir):=0A=
             return True=0A=
-        if 'tag' in ud.parm and not self._contains_ref(ud, d, ud.name, ud.=
clonedir, tag=3DTrue):=0A=
+        if 'tag' in ud.parm and not self._contains_ref(ud, d, ud.name, clo=
nedir, tag=3DTrue):=0A=
             return True=0A=
         return False=0A=
 =0A=
@@ -339,10 +341,11 @@ class Git(FetchMethod):=0A=
             return True=0A=
         return False=0A=
 =0A=
-    def clonedir_need_shallow_revs(self, ud, d):=0A=
+    def clonedir_need_shallow_revs(self, ud, d, clonedir=3DNone):=0A=
+        clonedir =3D clonedir or ud.clonedir=0A=
         for rev in ud.shallow_revs:=0A=
             try:=0A=
-                runfetchcmd(ud.basecmd + ['rev-parse', '-q', '--verify', r=
ev], d, quiet=3DTrue, workdir=3Dud.clonedir)=0A=
+                runfetchcmd(ud.basecmd + ['rev-parse', '-q', '--verify', r=
ev], d, quiet=3DTrue, workdir=3Dclonedir)=0A=
             except bb.fetch.FetchError:=0A=
                 return rev=0A=
         return None=0A=
@@ -353,13 +356,6 @@ class Git(FetchMethod):=0A=
     def tarball_need_update(self, ud):=0A=
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)=0A=
 =0A=
-    def update_mirror_links(self, ud, origud):=0A=
-        super().update_mirror_links(ud, origud)=0A=
-        # When using shallow mode, add a symlink to the original fullshall=
ow=0A=
-        # path to ensure a valid symlink even in the `PREMIRRORS` case=0A=
-        if origud.shallow and not os.path.exists(origud.fullshallow):=0A=
-            self.ensure_symlink(ud.localpath, origud.fullshallow)=0A=
-=0A=
     def try_premirror(self, ud, d):=0A=
         # If we don't do this, updating an existing checkout with only pre=
mirrors=0A=
         # is not possible=0A=
@@ -695,28 +691,36 @@ class Git(FetchMethod):=0A=
         source_found =3D False=0A=
         update_mode =3D False=0A=
         source_error =3D []=0A=
-=0A=
-        clonedir_is_up_to_date =3D not self.clonedir_need_update(ud, d)=0A=
+        clonedir =3D ud.clonedir=0A=
+        fullshallow =3D getattr(ud, "fullshallow", None)=0A=
+        if hasattr(ud, "mirrorpath"):=0A=
+            mirrorpath =3D downloaded_path(ud)=0A=
+            if os.path.isdir(mirrorpath):=0A=
+                clonedir =3D mirrorpath=0A=
+            elif ud.shallow:=0A=
+                fullshallow =3D mirrorpath=0A=
+=0A=
+        clonedir_is_up_to_date =3D not self.clonedir_need_update(ud, d, cl=
onedir)=0A=
         if clonedir_is_up_to_date:=0A=
             if update and os.path.exists(destdir):=0A=
                 update_mode =3D True=0A=
             else:=0A=
-                runfetchcmd(ud.basecmd + ['clone'] + ud.cloneflags + [ud.c=
lonedir, destdir], d, extraenv=3Dextraenv)=0A=
+                runfetchcmd(ud.basecmd + ['clone'] + ud.cloneflags + [clon=
edir, destdir], d, extraenv=3Dextraenv)=0A=
             source_found =3D True=0A=
         else:=0A=
-            source_error.append("clone directory not available or not up t=
o date: " + ud.clonedir)=0A=
+            source_error.append("clone directory not available or not up t=
o date: " + clonedir)=0A=
 =0A=
         if not source_found:=0A=
             if ud.shallow:=0A=
-                if os.path.exists(ud.fullshallow):=0A=
+                if os.path.exists(fullshallow):=0A=
                     if update and os.path.exists(destdir):=0A=
                         update_mode =3D True=0A=
                     else:=0A=
                         bb.utils.mkdirhier(destdir)=0A=
-                        runfetchcmd(['tar', '-xzf', ud.fullshallow], d, wo=
rkdir=3Ddestdir)=0A=
+                        runfetchcmd(['tar', '-xzf', fullshallow], d, workd=
ir=3Ddestdir)=0A=
                     source_found =3D True=0A=
                 else:=0A=
-                    source_error.append("shallow clone not available: " + =
ud.fullshallow)=0A=
+                    source_error.append("shallow clone not available: " + =
fullshallow)=0A=
             else:=0A=
                 source_error.append("shallow clone not enabled")=0A=
 =0A=
@@ -735,8 +739,8 @@ class Git(FetchMethod):=0A=
             try:=0A=
                 runfetchcmd(ud.basecmd + ['remote', 'get-url', 'dldir'], d=
, workdir=3Ddestdir)=0A=
             except bb.fetch.FetchError:=0A=
-                if ud.clonedir:=0A=
-                    runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', 'f=
ile://' + ud.clonedir], d, workdir=3Ddestdir)=0A=
+                if clonedir:=0A=
+                    runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', 'f=
ile://' + clonedir], d, workdir=3Ddestdir)=0A=
             try:=0A=
                 runfetchcmd(ud.basecmd + ['fetch', 'dldir'], d, workdir=3D=
destdir, extraenv=3Dextraenv)=0A=
             except bb.fetch.FetchError as e:=0A=
@@ -767,11 +771,11 @@ class Git(FetchMethod):=0A=
 =0A=
         repourl =3D self._get_repo_url(ud)=0A=
         runfetchcmd(ud.basecmd + ['remote', 'set-url', 'origin', repourl],=
 d, workdir=3Ddestdir)=0A=
-        if ud.clonedir:=0A=
+        if clonedir:=0A=
             try:=0A=
                 runfetchcmd(ud.basecmd + ['remote', 'get-url', 'dldir'], d=
, workdir=3Ddestdir)=0A=
             except bb.fetch.FetchError:=0A=
-                runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', "file:=
//" + ud.clonedir], d, workdir=3Ddestdir)=0A=
+                runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', "file:=
//" + clonedir], d, workdir=3Ddestdir)=0A=
 =0A=
         if self._contains_lfs(ud, d, destdir):=0A=
             if not need_lfs:=0A=
@@ -802,12 +806,6 @@ class Git(FetchMethod):=0A=
         """ clean the git directory """=0A=
 =0A=
         to_remove =3D [ud.localpath, ud.fullmirror, ud.fullmirror + ".done=
"]=0A=
-        # The localpath is a symlink to clonedir when it is cloned from a=
=0A=
-        # mirror, so remove both of them.=0A=
-        if os.path.islink(ud.localpath):=0A=
-            clonedir =3D os.path.realpath(ud.localpath)=0A=
-            to_remove.append(clonedir)=0A=
-=0A=
         # Remove shallow mirror tarball=0A=
         if ud.shallow:=0A=
             to_remove.append(ud.fullshallow)=0A=
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py=0A=
index 71b0a63f..518d219b 100644=0A=
--- a/lib/bb/tests/fetch.py=0A=
+++ b/lib/bb/tests/fetch.py=0A=
@@ -616,6 +616,55 @@ class GitDownloadDirectoryNamingTest(FetcherTest):=0A=
         self.assertIn(self.recipe_dir, dir)=0A=
 =0A=
 =0A=
+class GitPremirrorStaleCloneTest(FetcherTest):=0A=
+=0A=
+    def test_premirror_ignores_stale_clone(self):=0A=
+        source =3D os.path.join(self.tempdir, "source")=0A=
+        os.mkdir(source)=0A=
+        self.git_init(cwd=3Dsource)=0A=
+=0A=
+        testfile =3D os.path.join(source, "testfile")=0A=
+        with open(testfile, "w") as f:=0A=
+            f.write("first\n")=0A=
+        self.git(["add", "testfile"], cwd=3Dsource)=0A=
+        self.git(["commit", "-m", "first commit"], cwd=3Dsource)=0A=
+        stale_revision =3D self.git(["rev-parse", "HEAD"], cwd=3Dsource).s=
trip()=0A=
+=0A=
+        recipe_url =3D "git://upstream.invalid/project.git;branch=3Dmaster=
;protocol=3Dhttps"=0A=
+        self.d.setVar("SRCREV", stale_revision)=0A=
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)=0A=
+        ud =3D fetcher.ud[recipe_url]=0A=
+        ud.setup_localpath(self.d)=0A=
+        os.makedirs(os.path.dirname(ud.clonedir), exist_ok=3DTrue)=0A=
+        self.git(["clone", "--bare", "--mirror", source, ud.clonedir], cwd=
=3Dself.tempdir)=0A=
+        stale_clone =3D ud.clonedir=0A=
+=0A=
+        with open(testfile, "a") as f:=0A=
+            f.write("second\n")=0A=
+        self.git(["commit", "-am", "second commit"], cwd=3Dsource)=0A=
+        revision =3D self.git(["rev-parse", "HEAD"], cwd=3Dsource).strip()=
=0A=
+=0A=
+        self.d.setVar("SRCREV", revision)=0A=
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")=0A=
+        self.d.setVar("BB_NO_NETWORK", "1")=0A=
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=3Dfile" % (recip=
e_url, source))=0A=
+=0A=
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)=0A=
+        fetcher.download()=0A=
+        fetcher.unpack(self.unpackdir)=0A=
+=0A=
+        self.assertFalse(os.path.islink(stale_clone))=0A=
+        self.assertEqual(stale_revision,=0A=
+                         self.git(["rev-parse", "HEAD"], cwd=3Dstale_clone=
).strip())=0A=
+        unpack_revision =3D self.git(["rev-parse", "HEAD"],=0A=
+                                   cwd=3Dos.path.join(self.unpackdir, "git=
")).strip()=0A=
+        self.assertEqual(revision, unpack_revision)=0A=
+=0A=
+        mirrorpath =3D fetcher.ud[recipe_url].mirrorpath=0A=
+        fetcher.clean()=0A=
+        self.assertTrue(os.path.exists(mirrorpath))=0A=
+=0A=
+=0A=
 class TarballNamingTest(FetcherTest):=0A=
     def setUp(self):=0A=
         super(TarballNamingTest, self).setUp()=0A=
-- =0A=
2.55.0=0A=

