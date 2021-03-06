/**
 * Site localization
 *
 * @encoding utf-8
 * @author Viacheslav Lotsmanov
 */

module.exports =
	\ru :
		\err :
			\styles :
				\path-detect : '''
					Произошла ошибка при инициализации сайта.

					Не удалось обнаружить путь до файла стилей CSS.
				'''
				\load-timeout : '''
					Произошла ошибка при инициализации сайта.

					Истекло время ожидания загрузки CSS стилей сайта.
				'''
				\xhr-load : '''
					Произошла ошибка при инициализации сайта.

					Не удалось загрузить стили сайта.

					Код ошибки: #ERROR_CODE#
				'''

			\preload-img : '''
				Произошла ошибка при инициализации сайта.

				Не удалось осуществить загрузку изображения.

				Путь до изображения: "#IMAGE_SRC#"

				Код ошибки: #ERROR_CODE#
			'''

			\preload-img-timeout : '''
				Произошла ошибка при инициализации сайта.

				Не удалось осуществить загрузку изображения.

				Истекло время ожидания.

				Путь до изображения: "#IMAGE_SRC#"
			'''

			\detect-link-anchor : '''
				Произошла ошибка при попытке определить целевое назначение ссылки.

				Не обнаружен блок для перехода по ссылке.

				Ссылка: "#LINK_HREF#"
			'''

			\yandex-map-load-api : '''
				Произошла ошибка при попытке загрузить API Янднекс.Карт.

				Ошибка: #ERROR_CODE#
			'''

			\yandex-map-not-enough-data : '''
				Недостаточно данных для построения карты.
			'''

			\not-implemented-yet : '''
				Ещё не реализовано.
			'''

			\ajax :
				\required-field : "Не заполнено обязательное поле"
				\incorrect-field : "Поле заполнено некорректно"
				\unknown-error : "Неизвестная ошибка в ответе от сервера."

		\forms :
			\feedback-success-msgbox : '''
				Спасибо! Ваше сообщение успешно отправлено.
			'''
