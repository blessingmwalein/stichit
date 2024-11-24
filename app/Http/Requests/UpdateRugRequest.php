<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateRugRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'string',
            'type' => 'in:small,medium,large',
            'approx_production_cost' => 'numeric',
            'approx_cost' => 'numeric',
            'sizes' => 'array',
            'sizes.*.width' => 'numeric',
            'sizes.*.length' => 'numeric',
        ];
    }
}
